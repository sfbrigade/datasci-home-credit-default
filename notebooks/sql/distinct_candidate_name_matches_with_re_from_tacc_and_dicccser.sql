
-- Query 1: This counts the distinct candidate name matches with re_ from tacc_ and dicccser_ data.
-- The election cycle time interval of tacc_ is limited to the dicccser_.
-- Results: 142

with table_one as
(
select
  recipient_candidate_name, 
  count(recipient_candidate_name) as occur_one,
  regexp_replace(lower(split_part(recipient_candidate_name, ',', 2) || split_part(recipient_candidate_name, ',', 1)), '[^a-z]', '', 'g') as re_name_one
from trg_analytics.candidate_contributions
where cast(election_cycle as int) >= 2009

group by recipient_candidate_name
),

table_two as
(
select
  candidate_name, 
  count(candidate_name) as occur_two,
  regexp_replace(lower(split_part(candidate_name, ',', 2) || split_part(candidate_name, ',', 1)), '[^a-z]', '', 'g') as re_name_two
 from data_ingest.casos__california_candidate_statewide_election_results
 where county_name like 'State Totals' 
  and contest_name not like 'President%'
  and contest_name not like 'president%'
  and contest_name not like 'US Senate%' 
  and contest_name not like 'United States Representative%'
  and contest_name not like 'us'
  and contest_name not like 'united%'
  and contest_name not like '%Congressional District'
 group by candidate_name
)

select count(sub.temp )
from (

    select
      candidate_name,
      table_one.re_name_one as temp,
      table_one.occur_one,
      recipient_candidate_name,
      table_two.re_name_two,
      table_two.occur_two
    from table_two
    join table_one
    on re_name_one = re_name_two
    order by re_name_one
) sub
