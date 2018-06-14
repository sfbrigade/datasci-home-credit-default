# Spec Name: ETL Election Results Data

## Goals
The goal of this project will be to download, clean, parse, and load California State Election Result data from the [California Secretary of State](http://www.sos.ca.gov/elections/prior-elections/statewide-election-results/) for every election cycle going back to 2002. Bonus points if we can do the same for all election cycles going back through 1990.

## Resources
This project will mostly require data science and data engineering resources. In addition, general domain knowledge about election processes in California will be immensely helpful (i.e. anyone who is interested please help!) 

## Dates
We estimate that this project should take (at most) two weeks.

1. Start Date: 2018-02-07
2. Estimated End Date: 2018-02-21
3. Actual End Date: 

## Background and Significance (why are we doing this?)
Having election results data in our database will give us a key data point in our statistical analysis examining whether political contribution amounts and sources affect election outcomes.

## Definition of Done

**MVP (Minimal Viable Product) Requirements:**

We have tables in our Postgres DB with election results data:

1. `data_ingest.casos__california_candidate_statewide_election_results`: Contains California Statewide election results from the [California Secretary of State](http://www.sos.ca.gov/elections/prior-elections/statewide-election-results/) going back to at least 2002. Bonus points if we load everything going back to 1990.
2. `stg_analytics.stg_election_results`: Data from `data_ingest.casos__california_candidate_statewide_election_results` should be transformed into `stg_analytics.stg_election_results`. Although we currently have election results data from one source (California Secretary of State; Statewide elections), we should think about a data model that generalizes to when we have multiple sources of election data. Setting up this general table now (e.g. `stg_analytics.stg_election_results`) will give us the framework to plug in with new data later. We currently propose the following schema structure for the table (but would love your feedback!):

| Column Name | Data Type | Column Description |
|------------ |-----------|------------|
| election_name | text    | The overall election name (e.g. "2016 General")
| contest_name  | text    | Within an election, there may be several contests. For example, US Senate Elections, CA State Senate Elections
| election_date | date    | The date of the election
| geographic_type | text  | General description of the geography (e.g. county, state). There should be one value called "totals" which gives the election totals.
| geographic_subtype | text| The identifier of the geographic type. For example, might be "name" or "FIPS" code
| geographic_id | text     | The actual ID of the geographic area. This might be the actual FIPS code, the zip-code, etc.
| geographic_name | text     | The actual name of the geographic area. This might be the county name.
| candidate_id | text| The candidate ID. Need to think about how this relates to IDs from other data sources
| candidate_name | text     | The candidate name
| incumbent_flag | boolean     | Whether the candidate is an incumbent
| write_in_flag | boolean | Whether the candidate is a write-in
| party_id      | text    | Political Party ID (do we need this?)
| party_name    | text    | Political Party Name
| vote_total    | bigint  | Total Votes

## Path to MVP
In this section, we propose an example path to achieve the MVP (however, feel free to change/update as appropriate!)

1. For the 2016 data, the California Secretary of State already aggregate all the candidate election results data in a nicely formatted CSV. For previous years, the California Secretary of State do not do this and instead break each contest into separate files. Download all the previous years data for each contest into their respective folders within the [src](../../src/casos) directory.
2. Write a [pipeline task](../../pipeline/pipeline_tasks/parse/clean_casos_california_statewide_election_results.py) to clean each file and write a new file named csv-candidates-YYYY.xls within the [src/casos](../../src/casos) directory.
3. Use the [load pipeline task](../../pipeline/pipeline_tasks/parse/load_casos_california_statewide_election_results.py) to load into our database
4. Write a query within [stg_analytics](../../pipeline/pipeline_tasks/queries/stg_analytics) to get into general format described above.

## External Citations

## Out of Scope
Proposal: Let's focus on general elections for now? Would it be safe to ignore special elections and primaries and get back to them later if needed?
