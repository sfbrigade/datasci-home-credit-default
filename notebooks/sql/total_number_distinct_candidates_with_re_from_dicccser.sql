-- Query 5: This counts the total number of distinct candidate_name from dicccser_ data.
-- Results: 225

select count( sub.re_name) as distinct_re_name_dicccser
from (
  select
    distinct(regexp_replace(lower(split_part(candidate_name, ',', 2) || split_part(candidate_name, ', ', 1)), '[^a-z]', '', 'g') )as re_name
  from data_ingest.casos__california_candidate_statewide_election_results
 where county_name like 'State Totals' 
  and contest_name not like 'President%'
  and contest_name not like 'president%'
  and contest_name not like 'US Senate%' 
  and contest_name not like 'United States Representative%'
  and contest_name not like 'us'
  and contest_name not like 'united%'
  and contest_name not like '%Congressional District'
)sub
