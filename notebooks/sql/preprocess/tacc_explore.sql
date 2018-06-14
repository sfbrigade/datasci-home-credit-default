-- https://modeanalytics.com/editor/code_for_san_francisco/reports/4eb2493a61af
-- Query 1
-- The goal is to identify missing or null values in each attribute, since it will help us
-- select key features to execute machine learning algorithms. 
-- Findings: 10 columns out of 27 have anomolies.

select
  count(*),
  --donor_city 
  donor_committee_id -- 1502264 NOT CURRENTLY SUPPORTED
  --donor_committee_name -- 1502264 NOT CURRENTLY SUPPORTED
  --donor_committee_party -- 1502264 empty/NULL
  --donor_committee_type -- 1502264 empty/NULL
  --donor_employer 
  --donor_entity_type -- 1502264 NOT CURRENTLY SUPPORTED
  --donor_industry
  --donor_name
  --donor_occupation -- 1502264 NOT CURRENTLY SUPPORTED
  --donor_organization
  --donor_state
  --donor_zip_code
  --election
  --election_cycle
  --filed_date
  --primary_general_indicator -- 1502264  '0' zero value
  --recipient_candidate_district -- 399240  empty/NULL
  --recipient_candidate_ico -- 1502264 empty/NULL
  --recipient_candidate_name -- 1371 empty/NULL
  --recipient_candidate_office
  --recipient_candidate_party -- 1502264 NOT CURRENTLY SUPPORTED
  --recipient_candidate_status -- 1502264 NOT CURRENTLY SUPPORTED
  --recipient_committee_name
  --transaction_amount
  --transaction_date
  --transaction_id
  --transaction_type
from trg_analytics.candidate_contributions
group by
  --donor_city
  donor_committee_id
  --donor_committee_name
  --donor_committee_party
  --donor_committee_type
  --donor_employer
  --donor_entity_type
  --donor_industry
  --donor_name
  --donor_occupation
  --donor_organization
  --donor_state
  --donor_zip_code
  --election
  --election_cycle
  --filed_date
  --primary_general_indicator
  --recipient_candidate_district
  --recipient_candidate_ico
  --recipient_candidate_name
  --recipient_candidate_office
  --recipient_candidate_party
  --recipient_candidate_status
  --recipient_committee_name
  --transaction_amount
  --transaction_date
  --transaction_id
  --transaction_type
