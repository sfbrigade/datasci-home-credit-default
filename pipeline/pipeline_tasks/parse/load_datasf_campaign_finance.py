"""
Load SF Data Campaign Finance Data

Source of data: https://data.sfgov.org/City-Management-and-Ethics/Campaign-Finance-FPPC-Form-460-Schedule-A-Monetary/q66q-d2tr

We'll just be loading the first 1000 rows to play around with it. We should probably use API when we formalize.
"""
import argparse
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
    print('Data SF Campaign Finance Data FPPC Form 460 Schedule A')
    df = pd.read_csv(os.path.join(direc, 'Campaign_Finance_-_FPPC_Form_460_-_Schedule_A_-_Monetary_Contributions_test.csv'))

    print('Writing Data SF Data')
    dbm.write_df_table(
        df,
        table_name='sfdata__campaign_finance_form460_schedulea',
        schema='data_ingest')


def main():
    """Execute Stuff"""
    print('Parsing and Loading SF Data Campaign Finance Datasets')
    args = get_args()
    dbm = DBManager(db_url=args.db_url)
    git_root_dir = uf.get_git_root(os.path.dirname(__file__))
    directory = os.path.join(git_root_dir, 'src')
    load_datasets(dbm, directory)


if __name__ == '__main__':
    """See https://stackoverflow.com/questions/419163/what-does-if-name-main-do"""
    main()

