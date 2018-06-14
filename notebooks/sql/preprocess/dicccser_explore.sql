-- https://modeanalytics.com/editor/code_for_san_francisco/reports/80fe013bbf32
-- Query 1
-- The goal is to identify missing or null values in each attribute, since it will help us
-- select key features to execute machine learning algorithms. 
-- This is the data_ingest.casos__california_candidate_statewide_election_results data.

select count(*),
candidate_name -- 40 empty/null
--contest_name
--county_name
--election_name
--incumbent_flag
--party_name -- 40 empty/null
--vote_total -- 40 empty/null

from data_ingest.casos__california_candidate_statewide_election_results
 where county_name like 'State Totals' 
    and contest_name not like 'President%'
    and contest_name not like 'president%'
    and contest_name not like 'US Senate%' 
    and contest_name not like 'United States Representative%'
    and contest_name not like 'us'
    and contest_name not like 'united%'
    and contest_name not like '%Congressional District'


group by
candidate_name
--contest_name 
--county_name
--election_name
--incumbent_flag
--party_name
--vote_total

order by 
candidate_name
--contest_name 
--county_name
--election_name
--incumbent_flag
--party_name
--vote_total
desc
