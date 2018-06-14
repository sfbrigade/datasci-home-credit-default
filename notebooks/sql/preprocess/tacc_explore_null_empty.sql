-- https://modeanalytics.com/editor/code_for_san_francisco/reports/4eb2493a61af
-- Query 3
-- The goal is to identify empty or null values in each attribute, since it will help us
-- select key features to execute machine learning algorithms. 
-- Total rows 1502264.

select
  count(*),
  --donor_city                -- 612  empty/null
  --donor_employer            -- 795064 empty/null
  --donor_industry            -- NO empty/null!  wow
  --donor_name                -- 13  empty/null
  --donor_organization        -- 30  empty/null
  --donor_state               -- 2247  empty/null
  --donor_zip_code            -- 2219  empty/null
  --election                  -- 311806  null; range 2059-01-01 to 1930-02-04
  --election_cycle            -- NO empty/null! wow
  --filed_date                -- NO null
  --recipient_candidate_district -- 399240  empty/NULL
  --recipient_candidate_name  -- 1371 empty/NULL
  --recipient_candidate_office -- NO  empty/null
  --recipient_committee_name  -- NO empty/null
  --transaction_amount        -- NO empty/null
  --transaction_date          -- 122 null; 24 transaction_date > NOW()
  --transaction_id            -- NO empty/null
  transaction_type          -- NO empty/null
from trg_analytics.candidate_contributions

where 
 --donor_city
  --donor_employer 
  --donor_industry
  --donor_name
  --donor_organization
  --donor_state
  --donor_zip_code
  --election
  --election_cycle
  --filed_date
  --recipient_candidate_district 
  --recipient_candidate_name -- 1371 empty/NULL
  --recipient_candidate_office
  --recipient_committee_name
  --transaction_amount
  --transaction_date
  --transaction_id
  transaction_type
is NULL or
  --donor_city 
  --donor_employer 
  --donor_industry
  --donor_name
  --donor_organization
  --donor_state
  --donor_zip_code
  --election - date
  --election_cycle
  --filed_date -- date
  --recipient_candidate_district 
  --recipient_candidate_name -- 1371 empty/NULL
  --recipient_candidate_office
  --recipient_committee_name
  --transaction_amount
  --transaction_date
  --transaction_id
  transaction_type
  like ''
group by
  --donor_city 
  --donor_employer 
  --donor_industry
  --donor_name
  --donor_organization
  --donor_state
  --donor_zip_code
  --election
  --election_cycle
  --filed_date
  --recipient_candidate_district 
  --recipient_candidate_name 
  --recipient_candidate_office
  --recipient_committee_name
  --transaction_amount
  --transaction_date
  --transaction_id
  transaction_type

