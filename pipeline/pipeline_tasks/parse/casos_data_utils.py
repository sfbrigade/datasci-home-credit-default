"""
Utility Functions to Help Parse CA Secretary of State Election Results Data
"""

import argparse
import glob
import os
import re
import sys

import pandas as pd
import xlrd


def determine_incumbency_status(candidate_name):
    """
    Given a Candidate Name determine whether the candidate was the incumbent.
    
    Keyword Args:
        candidate_name: The Candidate's Name. If there's an "*", then the candidate is the incumbent.
                        In the CA SOS Data, the candidate is marked as an incumbent by putting a "*" in their name.
    Return:
        True if candidate is the incumbent, else False
    """
    if(re.search('\*', candidate_name)):
        return 'Y'
    else:
        return 'N'


def process_contest(rows, election_name, contest_name):
    """
    Process Contest Results From CA SOS Statewide Election Results
    
    Keyword Args:
      rows: List of Rows from an XLRD Worksheet Object.
            The first row should be the candidate names.
            The last row should be the 'Totals' (Votes) Row.
      election_name: The name of the broader general election (e.g. 2016 General)
      contest_name: The name of the specific contest within the election (e.g. Governor)
    Return:
      contest_results: Pandas DataFrame with the contest results unique at the:
                         1. contest_name
                         2. county_name
                         3. candidate_name
                       level.
    
    Note, this current implementation will only select the first two candidates.
    """
    # Create a Dictionary mapping
    #   1. Votes Column to Candidate
    #   2. Candidate to Party  
    candidate1 = ' '.join(rows[0][1].value.split())
    candidate2 = ' '.join(rows[0][2].value.split())
    party1 = rows[1][1].value
    party2 = rows[1][2].value

    vote_candidate_mapping = {
        'votes1': candidate1,
        'votes2': candidate2,
    }

    candidate_party_mapping = {
        candidate1: party1,
        candidate2: party2,
    }
    
    # Parse Values
    counties = []
    votes1 = []
    votes2 = []
    for r in range(len(rows)):
        contains_percent = re.search('percent', rows[r][0].value, re.IGNORECASE)
        contains_continued = re.search('continued', rows[r][0].value, re.IGNORECASE)
        if(contains_percent or rows[r][0].value == '' or contains_continued):
            pass
        else:
            counties.append(rows[r][0].value)
            votes1.append(rows[r][1].value)
            votes2.append(rows[r][2].value)
            
    df = pd.DataFrame({
        'county_name': counties,
        'votes1': votes1,
        'votes2': votes2,
    })
    
    # Rename Columns to Actual Candidate Names before Reshaping
    df.rename(index=str, columns=vote_candidate_mapping, inplace=True)
    
    # Pivot the DataFrame to get at the county/candidate level
    contest_results = pd.melt(df, id_vars=['county_name'], var_name='candidate_name', value_name='vote_total')
    
    # Add Additional Columns
    contest_results['election_name'] = election_name
    contest_results['contest_name'] = contest_name
    contest_results['party_name'] = contest_results.candidate_name.map(candidate_party_mapping)
    contest_results['incumbent_flag'] = contest_results.candidate_name.apply(determine_incumbency_status)
    
    # Reorder Columns
    cols = [
        'election_name',
        'county_name',
        'contest_name',
        'candidate_name',
        'incumbent_flag',
        'party_name',
        'vote_total',
    ]

    contest_results = contest_results[cols]
    return contest_results


def get_district_metadata(rows):
    """
    Gets the Metadata associated with District Level Election Results from CA SOS Data
    
    Keyword Args:
      rows: List of Rows from an XLRD Worksheet Object.
            This should be a list of all rows from an Excel file containing Election Results
    Returns:
      district_metadata: Python Dictionary with the contest_name as keys and as values another dictionary with keys:
                           row_indices=(starting_index, end_index),
                           contest_name,
    """
    contest_name_idx = []
    total_votes_idx = []

    # Contest Name is inside the spreadsheet
    for r in range(len(rows)):
        contains_district = re.search('district', rows[r][0].value, re.IGNORECASE)
        contains_totals = re.search('totals', rows[r][0].value, re.IGNORECASE)
        contains_continued = re.search('continued', rows[r][0].value, re.IGNORECASE)
        if(contains_district and not(contains_totals) and not(contains_continued)):
            contest_name_idx.append(r)
        if(contains_totals):
            total_votes_idx.append(r)

    # Assumes the voting results starts 2 rows after the District Name. This is very Hacky
    starting_idx = [i + 2 for i in contest_name_idx]
    
    district_metadata = {}
    for (cni, si, tvi) in zip(contest_name_idx, starting_idx, total_votes_idx):
        contest_name = rows[cni][0].value
        district_metadata[contest_name] = {'row_indices': (si, tvi + 1), 'contest_name': contest_name}
    
    return district_metadata