-- https://modeanalytics.com/editor/code_for_san_francisco/reports/b55118c60f67
-- Query 2
-- The user enters the recipient_candidate_name. 
-- This returns the election cycle, number of refunds, total refunded amount, total 
-- contributions and a scaled amount demonstrating the impact on the total contributions.

with table_a as (

select
  recipient_candidate_name,
  election_cycle,
  sum(transaction_amount) as total_trans_amount
from trg_analytics.candidate_contributions
where recipient_candidate_name like '%YEE, LELAND Y.%'
group by recipient_candidate_name, election_cycle
order by election_cycle desc
), 

table_b as (
select
  recipient_candidate_name,
  election_cycle,
  sum(transaction_amount) as refund_trans_amount,
  count(transaction_amount) as num_refunds
from trg_analytics.candidate_contributions
where recipient_candidate_name like '%YEE, LELAND Y.%'
  and  transaction_amount < 0
group by recipient_candidate_name, election_cycle

order by election_cycle desc
)

select 
  table_a.recipient_candidate_name,
  table_a.election_cycle,
  num_refunds,
  refund_trans_amount,
  total_trans_amount,
  -1 * refund_trans_amount / total_trans_amount as scaled_refund_amount
from table_a
join table_b
on table_a.recipient_candidate_name = table_b.recipient_candidate_name
and table_a.election_cycle = table_b.election_cycle
  
