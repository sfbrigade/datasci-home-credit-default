"""
Load MapLight California Money and Politics Bulk Data Set

Source of data: https://maplight.org/data_guide/california-money-and-politics-bulk-data-set/

Likely will want to use API in the future for more dynamic ETL.
"""
import argparse
import glob
import os

import pandas as pd
import sqlalchemy as sa

from utilities.db_manager import DBManager
from utilities import util_functions as uf


def get_args():
    """Use argparse to parse command line arguments."""
    parser = argparse.ArgumentParser(description='Runner for tasks')
    parser.add_argument('--db_url', help='Database url string to the db.', required=True)
    return parser.parse_args()


def load_datasets(dbm, direc):
    """Data SF Campaign Finance Data

    Keyword Args:
        dbm: DBManager object
        dir: Directory where files are
    """
    extension = 'csv'
    filenames = os.listdir(direc)
    files = [filename for filename in filenames if filename.endswith(extension)]
    cand_files = [f for f in files if 'cand' in f]
    other_files = [f for f in files if 'other' in f]

    column_map = {
        'TransactionType': 'transaction_type',
        'ElectionCycle': 'election_cycle',
        'Election': 'election',
        'PrimaryGeneralIndicator': 'primary_general_indicator',
        'TransactionID': 'transaction_id',
        'TransactionDate': 'transaction_date',
        'TransactionAmount': 'transaction_amount',
        'FiledDate': 'filed_date',
        'RecipientCommitteeNameNormalized': 'recipient_committee_name',
        'RecipientCandidateNameNormalized': 'recipient_candidate_name',
        'RecipientCandidateParty': 'recipient_candidate_party',
        'RecipientCandidateICO': 'recipient_candidate_ico',
        'RecipientCandidateStatus': 'recipient_candidate_status',
        'RecipientCandidateOffice': 'recipient_candidate_office',
        'RecipientCandidateDistrict': 'recipient_candidate_district',
        'DonorNameNormalized': 'donor_name',
        'DonorCity': 'donor_city',
        'DonorState': 'donor_state',
        'DonorZipCode': 'donor_zip_code',
        'DonorEmployerNormalized': 'donor_employer',
        'DonorOccupationNormalized': 'donor_occupation',
        'DonorOrganization': 'donor_organization',
        'DonorIndustry': 'donor_industry',
        'DonorEntityType': 'donor_entity_type',
        'DonorCommitteeID': 'donor_committee_id',
        'DonorCommitteeNameNormalized': 'donor_committee_name',
        'DonorCommitteeType': 'donor_committee_type',
        'DonorCommitteeParty': 'donor_committee_party',
        'Target': 'target',
        'Position': 'position',
    }

    dtype_map = {
        'recipient_candidate_district': sa.types.String,
        'recipient_candidate_office': sa.types.String,
    }

    # Reading and Writing Candidate Files
    dfs = []
    for f in cand_files:
        print('Reading file {} into pandas.'.format(f))
        df = pd.read_csv(os.path.join(direc, f))
        df.rename(index=str, columns=column_map, inplace=True)
        dfs.append(df)

    print('Writing candidate files into database.')
    df = pd.concat(dfs, ignore_index=True)
    dbm.write_df_table(
        df,
        table_name='maplight__california_candidate',
        schema='data_ingest',
        dtype=dtype_map)

    # Reading and Writing Other Files
    dfs = []
    for f in other_files:
        print('Reading file {} into pandas.'.format(f))
        df = pd.read_csv(os.path.join(direc, f))
        df.rename(index=str, columns=column_map, inplace=True)
        dfs.append(df)

    print('Writing other files into database.')
    df = pd.concat(dfs, ignore_index=True)
    dbm.write_df_table(
        df,
        table_name='maplight__california_other',
        schema='data_ingest')


def main():
    """Execute Stuff"""
    print('Parsing and Loading MapLight California Bulk Data Sets')
    args = get_args()
    dbm = DBManager(db_url=args.db_url)
    git_root_dir = uf.get_git_root(os.path.dirname(__file__))
    directory = os.path.join(git_root_dir, 'src', 'maplight')
    load_datasets(dbm, directory)


if __name__ == '__main__':
    """See https://stackoverflow.com/questions/419163/what-does-if-name-main-do"""
    main()

