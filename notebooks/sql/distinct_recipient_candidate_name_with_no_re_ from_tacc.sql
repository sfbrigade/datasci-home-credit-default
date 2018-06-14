 -- This counts the distinct recipient_candidate_name with no re_ from tacc_ data.
-- Results: 1046
select count(sub.name) as distinct_original_names_tacc
from (
  select
      distinct(recipient_candidate_name) as name
  from trg_analytics.candidate_contributions
  where cast(election_cycle as int) >= 2009
) sub
