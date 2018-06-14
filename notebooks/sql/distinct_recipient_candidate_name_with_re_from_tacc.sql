-- Query 3: This counts the distinct recipient_candidate_name with re_ from tacc_ data.
-- Results: 1039 

select count(sub. re_name_distinct) as distinct_re_name_tacc
from (
  select
      distinct( regexp_replace(lower(split_part(recipient_candidate_name, ',', 2) || split_part(recipient_candidate_name, ',', 1)), '[^a-z]', '', 'g') )  as re_name_distinct
  from trg_analytics.candidate_contributions 
  where cast(election_cycle as int) >= 2009
) sub

