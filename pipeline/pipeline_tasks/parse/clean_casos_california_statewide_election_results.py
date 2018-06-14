"""
Clean CA SOS Statewide ELection Results

Source of data: http://www.sos.ca.gov/elections/prior-elections/statewide-election-results/

For years prior 2016, the California Secretary of State provide non-relational DB formats for
election results. Clean each years' files and for each year aggregate into one CSV file.

The output for each year should be a file called "csv-candidates-YYYY.xls" into the
https://github.com/sfbrigade/datasci-congressional-data/tree/master/src/casos folder.

We can then use load_casos_california_statewide_election_results.py to load those files in.
"""
import argparse
import glob
import os
import re

import pandas as pd
import sqlalchemy as sa
import xlrd
import xlwt

from pipeline.pipeline_tasks.parse.casos_data_utils import process_contest, get_district_metadata
from utilities.db_manager import DBManager
from utilities import util_functions as uf


# Hacky Implementation: Defining Globally the Statewide vs District Elections
STATEWIDE_ELECTIONS = [
    '19-governor.xls',
    '22-lieutenant-governor.xls',
    '25-secretary-of-state (1).xls',
    '28-controller.xls',
    '31-treasurer.xls',
    '34-attorney-general.xls',
    '37-insurance-commissioner.xls',
    '85-superintendent-of-public-instruction.xls',
    '10-president.xls',
    '11-us-senator.xls',
    '23-governor.xls',
    '29-lieutenant-governor.xls',
    '32-secretary-of-state.xls',
    '35-controller.xls',
    '38-treasurer.xls',
    '41-attorney-general.xls',
    '44-insurance-commissioner.xls',
    '47-superintendent-of-public-instruction.xls',
    '52-united-states-senator.xls',
]

DISTRICT_ELECTIONS = [
    '40-board-of-equalization.xls',
    '43-congress.xls',
    '58-state-senator.xls',
    '64-state-assemblymember.xls', 
    '12-us-reps.xls',
    '13-state-senators.xls',
    '14-state-assembly-1-80.xls',
    '50-board-of-equalization.xls',
    '58-united-states-representative.xls',
    '69-state-senate.xls',
    '73-state-assembly.xls',
]


def get_args():
    """Use argparse to parse command line arguments."""
    parser = argparse.ArgumentParser(description='Runner for tasks')
    parser.add_argument('--db_url', help='Database url string to the db.', required=True)
    return parser.parse_args()


def clean_datasets(dbm, direc):
    """
    CA SOS Statewide Election Data

    Keyword Args:
        dbm: DBManager object
        direc: Directory where files are
    """
    years = ['2010', '2012', '2014']
    for year in years:
        dir_files = os.listdir(os.path.join(direc, year))
        dir_files = [f for f in dir_files if f.endswith('.xls')]

        # Hard Code Election Name for now as the Year + 'General'
        election_name = '{} General'.format(year)

        # Create Results List where each element will be a DataFrame of Contest Results
        results = []
        for filename in dir_files:
            file = os.path.join(direc, year, filename)
            workbook = xlrd.open_workbook(file)
            worksheet = workbook.sheet_by_index(0)  # By Default usually there's only one sheet. This is Hacky. How to be robust?
            rows = [worksheet.row(r) for r in range(worksheet.nrows)]

            if(filename in STATEWIDE_ELECTIONS):
                # Extract Contest Name from Filename
                # Reg Exp: https://stackoverflow.com/questions/8199398/extracting-only-characters-from-a-string-in-python
                contest_name = re.findall(r"(?i)\b[a-z]+\b", filename)[0]
                contest_rows = rows
                contest_results = process_contest(
                    rows=contest_rows, election_name=election_name, contest_name=contest_name)
                results.append(contest_results)
            elif(filename in DISTRICT_ELECTIONS):
                # For District Elections:
                district_metadata = get_district_metadata(rows)
                for key in district_metadata:
                    contest_name = district_metadata[key]['contest_name']
                    starting_idx = district_metadata[key]['row_indices'][0]
                    ending_idx = district_metadata[key]['row_indices'][1]
                    contest_rows = rows[starting_idx:ending_idx]
                    contest_results = process_contest(
                        rows=contest_rows, election_name=election_name, contest_name=contest_name)
                    results.append(contest_results)
        df = pd.concat(results, ignore_index=True)
        df.to_excel(os.path.join(direc, 'csv-candidates-{}.xls'.format(year)), index=False)


def main():
    """Execute Stuff"""
    print('Cleaning California Statewide Election Results Data')
    args = get_args()
    dbm = DBManager(db_url=args.db_url)
    git_root_dir = uf.get_git_root(os.path.dirname(__file__))
    directory = os.path.join(git_root_dir, 'src', 'casos')
    clean_datasets(dbm, directory)


if __name__ == '__main__':
    """See https://stackoverflow.com/questions/419163/what-does-if-name-main-do"""
    main()

