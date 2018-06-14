-- This statement merges the tacc_ and dicccser_ tables based on  tacc_election cycle and removes 
-- all dicccser_  federal election results, produces a table with the candidate_name, total_transaction, 
-- and a numerical value of either 1(win) or 0(loss) indicating the election outcome.
-- Also, the code for every election cycle is available.

-- https://modeanalytics.com/editor/code_for_san_francisco/reports/23fa56dfb4eb
-- Query 1

with candidate_donations as
(
select
  regexp_replace(lower(split_part(recipient_candidate_name, ',', 2) || split_part(recipient_candidate_name, ',', 1)), '[^a-z]', '', 'g') as full_name,
  sum(transaction_amount) as total_transaction
from trg_analytics.candidate_contributions
where election_cycle = '2015'
--where cast(election_cycle as int) >= 2009
group by recipient_candidate_name
),

election_results as
(
select
  contest_name,
  regexp_replace(lower(split_part(candidate_name, ',', 2) || split_part(candidate_name, ',', 1)), '[^a-z]', '', 'g') as candidate_name,
  vote_total,
  rank() over (partition by contest_name order by vote_total desc) = 1 as is_winner
from data_ingest.casos__california_candidate_statewide_election_results
 where county_name like 'State Totals' 
  and contest_name not like 'President%'
  and contest_name not like 'president%'
  and contest_name not like 'US Senate%' 
  and contest_name not like 'United States Representative%'
  and contest_name not like 'us'
  and contest_name not like 'united%'
  and contest_name not like '%Congressional District'
)

select
  candidate_name,
  total_transaction,
  is_winner::int as is_winner
from candidate_donations
join election_results
on candidate_donations.full_name = election_results.candidate_name

