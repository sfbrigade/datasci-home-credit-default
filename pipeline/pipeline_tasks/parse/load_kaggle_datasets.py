"""
Load Datasets directly provided by Kaggle Competiiton

Source of data: 
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
    files.remove('HomeCredit_columns_description.csv')  # Don't need to parse in column description CSV
    files.remove('sample_submission.csv')  # Don't need to parse in column description CSV

    # Reading and Writing Files
    for f in files:
        print('Reading file {} into pandas.'.format(f))
        df = pd.read_csv(os.path.join(direc, f))
        df.columns = map(str.lower, df.columns)

        print('Writing file {} into database.'.format(f))
        table_name = f.replace('.csv', '').lower()
        dbm.write_df_table(
            df,
            table_name=table_name,
            schema='data_ingest',
            if_exists='replace')


def main():
    """Execute Stuff"""
    print('Parsing and Loading Kaggle Competition Datasets')
    args = get_args()
    dbm = DBManager(db_url=args.db_url)
    git_root_dir = uf.get_git_root(os.path.dirname(__file__))
    directory = os.path.join(git_root_dir, 'src', 'home-credit-default-risk')
    load_datasets(dbm, directory)


if __name__ == '__main__':
    """See https://stackoverflow.com/questions/419163/what-does-if-name-main-do"""
    main()

