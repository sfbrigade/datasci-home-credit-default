-- https://modeanalytics.com/editor/code_for_san_francisco/reports/3335e15a3439
-- Query 2
-- The recipient_candidate_name is entered by the user.
-- This produces the election cycle the candidate was involved, total candidate contributions 
-- for that election cycle, normalized lifetime contributions,
-- and normalized total of contributions for the entire election cycle. 
-- This helps identify large contributions in an election cycle.

with table_one as ( --total_contribution_per_election_cycle

  select 
    election_cycle,
    sum(transaction_amount) as one
  from trg_analytics.candidate_contributions
  group by election_cycle
  order by election_cycle desc
),

table_two as ( --cadidate_contribution_per_election_cycle

  select 
    recipient_candidate_name,
    election_cycle,
    sum(transaction_amount) as two
  from trg_analytics.candidate_contributions
  group by election_cycle, recipient_candidate_name
  order by election_cycle desc
),

table_three as( --total_candidate_lifetime_contributions

  select 
    recipient_candidate_name,
    sum(transaction_amount) as three
  from trg_analytics.candidate_contributions
  group by recipient_candidate_name
  order by three desc
)

--merge the tables
select

  table_two.recipient_candidate_name,
  table_two.election_cycle,
  table_two.two as candidate_contribution,
  
  table_three.recipient_candidate_name,
  table_two.two/table_three.three as scaled_lifetime_contribution,
  
  table_one.one as total_contributions_per_election_cycle,
  table_two.two/table_one.one as scaled_election_cycle_contributions

from table_two
  join table_three
    on table_two.recipient_candidate_name = table_three.recipient_candidate_name
  join table_one
    on    table_two.election_cycle = table_one.election_cycle
    
where table_two.recipient_candidate_name like '%BROWN, EDMUND G. (JERRY)%'
order by  table_two.election_cycle

