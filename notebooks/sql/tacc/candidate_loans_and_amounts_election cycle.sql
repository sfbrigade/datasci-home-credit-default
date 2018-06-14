-- https://modeanalytics.com/editor/code_for_san_francisco/reports/c8cb5e40e52e
-- Query 1
-- This is the solution for scavenger hunt question number eight.
-- It produces the recipient_candidate_name, election cycle, total loan amount for that election cycle, 
-- the total number of loans, and the office that recieved the loan.
-- Query 3 identifies the different types of contributions.

select 
  recipient_candidate_name,
  election_cycle,
  sum(transaction_amount) as loan_amount,
  count(transaction_type) as num_loans,
  recipient_candidate_office
from trg_analytics.candidate_contributions
where transaction_type like '%Loan%'
group by 
  recipient_candidate_name,
  election_cycle,
  recipient_candidate_office
order by 
  loan_amount desc,
  num_loans desc
