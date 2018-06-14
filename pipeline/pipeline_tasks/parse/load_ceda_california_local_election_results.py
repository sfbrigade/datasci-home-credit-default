"""
Load CEDA California Election Results Data

Source of data: https://maplight.org/data_guide/california-money-and-politics-bulk-data-set/

Data Dictionary: http://www.csus.edu/isr/projects/ceda%20reports/codebook2016.pdf

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


def get_args():
    """Use argparse to parse command line arguments."""
    parser = argparse.ArgumentParser(description='Runner for tasks')
    parser.add_argument('--db_url', help='Database url string to the db.', required=True)
    return parser.parse_args()


def load_datasets(dbm, direc):
    """CEDA Election Results Data

    Keyword Args:
        dbm: DBManager object
        dir: Directory where files are
    """
    filenames = os.listdir(direc)
    files = [filename for filename in filenames if filename.endswith('xls') or filename.endswith('xlsx')]

    column_map_cand = {
        'RACEID': 'race_id',
        'RaceID': 'race_id',
        'RecordID': 'record_id',
        'CO': 'co',
        'JUR': 'jur',
        'CNTYNAME': 'cntyname',
        'YEAR': 'year',
        'DATE': 'date',
        'PLACE': 'place',
        'CSD': 'csd',
        'OFFICE': 'office',
        'RECODE_OFFICE': 'recode_office',
        'RECODE_OFFNAME': 'recode_offname',
        'AREA': 'area',
        'TERM': 'term',
        'VOTE#': 'vote_number',
        'LAST': 'last',
        'FIRST': 'first',
        'BALDESIG': 'baldesig',
        'INCUMB': 'incumb',
        'INC': 'incumb',
        'NUM_INC': 'num_inc',
        'Num_Inc': 'num_inc',
        'CAND#': 'cand_number',
        'VOTES': 'votes',
        'WRITEIN': 'writein',
        'SUMVOTES': 'sumvotes',
        'VOTES_sum': 'sumvotes',
        'TOTVOTES': 'totvotes',
        'RVOTES': 'rvotes',
        'PERCENT': 'percent',
        'Percent': 'percent',
        'ELECTED': 'elected',
        'elected': 'elected',
        'RUNOFF': 'runoff',
        'runoff': 'runoff',
        'CHECKRUNOFF': 'checkrunoff',
        'checkrunoff': 'checkrunoff',
        'Multi_RaceID': 'multi_race_id',
        'Multi_CandID': 'multi_cand_id',
        'Multi_CO': 'multi_co',
        'Indivtotal_votes': 'indivtotal_votes',
        'indivtotal_votes': 'indivtotal_votes',
        'Multitotal_votes': 'multitotal_votes',
        'multitotal_votes': 'multitotal_votes',
        'Total_writein': 'total_writein_votes',
        'total_writein': 'total_writein_votes',
        'Total_writein_votes': 'total_writein_votes',
        'Totalwritein_votes': 'total_writein_votes',
        'Newtotvotes': 'newtovotes',
        'newtotvotes': 'newtovotes',
        'Rindivto': 'rindivto',
        'Newelected': 'newelected',
        'newelected': 'newelected',
    }

    # Reading and Writing Candidate Files
    dfs = []
    for f in files:
        print('Reading file {} into pandas.'.format(f))
        year = re.findall(r'\d+', f)[0]
        if year == '2014' or year == '2015':
            sheet_name = 'candidates{}'.format(year)
        elif year == '2016':
            sheet_name = 'Candidates_{}'.format(year)
        else:
            sheet_name = 'Candidates{}'.format(year)
        df = pd.read_excel(os.path.join(direc, f), sheet_name=sheet_name)
        
        # Doing some relatively hacky file specific fixes since not 100% standard format
        if year == '2011' or year == '2013' or year == '2014' or year == '2015':
            df.drop(columns=['RACEID'], inplace=True)

        df.rename(index=str, columns=column_map_cand, inplace=True)
        dfs.append(df)

    print('Writing candidate election results into database.')
    df = pd.concat(dfs, ignore_index=True)
    dbm.write_df_table(
        df,
        table_name='ceda__california_candidate_local_election_results',
        schema='data_ingest')


def main():
    """Execute Stuff"""
    print('Parsing and Loading California Local Election Results Data')
    args = get_args()
    dbm = DBManager(db_url=args.db_url)
    git_root_dir = uf.get_git_root(os.path.dirname(__file__))
    directory = os.path.join(git_root_dir, 'src', 'ceda')
    load_datasets(dbm, directory)


if __name__ == '__main__':
    """See https://stackoverflow.com/questions/419163/what-does-if-name-main-do"""
    main()

