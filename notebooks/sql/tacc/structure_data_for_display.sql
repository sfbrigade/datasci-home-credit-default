-- https://modeanalytics.com/editor/code_for_san_francisco/reports/0c1e67375474
-- Query 2
-- The user enters the candidates ofice.
-- This returns the election cycle, cnadidate office name, the donor zip, the number of 
-- contributions from that zip code, total donor contribution, and the average contribution amount.
-- This shows the flow of money from specific zip codes to a specific office.

with table_c as ( --provides more exact details

select
  election_cycle,
  recipient_candidate_office,
  donor_zip_code,
  count(donor_zip_code) as num_donor_zips,
  sum(transaction_amount) as total_donor_transaction,
  case
    when count(donor_zip_code) !=0
    then sum(transaction_amount) / count(donor_zip_code) 
    else 0 
  end as avg_trans_per_donor
from trg_analytics.candidate_contributions
group by election_cycle, recipient_candidate_office, donor_zip_code
order by election_cycle desc, num_donor_zips desc

)
-- total numbers
select
  election_cycle,
  recipient_candidate_office,
  sum(total_donor_transaction) as total_contrib,
  count(recipient_candidate_office) as num_candidate_office,
  sum(num_donor_zips) as total_donors_zips
from table_c
group by recipient_candidate_office, election_cycle
order by total_contrib desc, num_candidate_office desc, total_donors_zips desc
  
