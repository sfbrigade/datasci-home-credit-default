"""
Load CA SOS Statewide ELection Results

Source of data: http://www.sos.ca.gov/elections/prior-elections/statewide-election-results/

Likely will want to use API in the future for more dynamic ETL.
"""
import argparse
import glob
import os
import re

import pandas as pd
import sqlalchemy as sa

from utilities.db_manager import DBManager
from utilities import util_functions as uf


# The only columns we care about
COLS = [
    'election_name',
    'county_name',
    'contest_name',
    'candidate_name',
    'incumbent_flag',
    'party_name',
    'vote_total',
]



def get_args():
    """Use argparse to parse command line arguments."""
    parser = argparse.ArgumentParser(description='Runner for tasks')
    parser.add_argument('--db_url', help='Database url string to the db.', required=True)
    return parser.parse_args()


def load_datasets(dbm, direc):
    """
    CA SOS Statewide Election Data

    Keyword Args:
        dbm: DBManager object
        dir: Directory where files are
    """
    filenames = os.listdir(direc)
    files = [filename for filename in filenames if filename.endswith('xls') or filename.endswith('xlsx')]

    column_map_cand = {
        'ELECTION_DATE': 'election_date',
        'ELECTION_NAME': 'election_name',
        'COUNTY_ID': 'county_id',
        'COUNTY_NAME': 'county_name',
        'CONTEST_ID': 'county_id',
        'CONTEST_NAME': 'contest_name',
        'CANDIDATE_ID': 'candidate_id',
        'CANDIDATE_NAME': 'candidate_name',
        'INCUMBENT_FLAG': 'incumbent_flag',
        'WRITE_IN_FLAG': 'write_in_flag',
        'PARTY_ID': 'party_id',
        'PARTY_NAME': 'party_name',
        'VOTE_TOTAL': 'vote_total',
    }

    # Reading and Writing Candidate Files
    dfs = []
    for f in files:
        print('Reading file {} into pandas.'.format(f))
        df = pd.read_excel(os.path.join(direc, f))
        df.rename(index=str, columns=column_map_cand, inplace=True)
        df = df[COLS]
        dfs.append(df)

    print('Writing candidate election results into database.')
    df = pd.concat(dfs, ignore_index=True)
    dbm.write_df_table(
        df,
        table_name='casos__california_candidate_statewide_election_results',
        schema='data_ingest',
        use_fast=False)


def main():
    """Execute Stuff"""
    print('Parsing and Loading California Statewide Election Results Data')
    args = get_args()
    dbm = DBManager(db_url=args.db_url)
    git_root_dir = uf.get_git_root(os.path.dirname(__file__))
    directory = os.path.join(git_root_dir, 'src', 'casos')
    load_datasets(dbm, directory)


if __name__ == '__main__':
    """See https://stackoverflow.com/questions/419163/what-does-if-name-main-do"""
    main()

