/*
This query combines various sources of candidate donation data.

Currently, the table only has California candidate donation data sourced from maplight
*/

drop table if exists trg_analytics.candidate_contributions;
create table trg_analytics.candidate_contributions
(
  transaction_id text,
  transaction_type text,
  election_cycle text,
  election date,
  primary_general_indicator int,
  transaction_date date,
  transaction_amount numeric,
  filed_date date,
  recipient_committee_name text,
  recipient_candidate_name text,
  recipient_candidate_party text,
  recipient_candidate_ico text,
  recipient_candidate_status text,
  recipient_candidate_office text,
  recipient_candidate_district text,
  donor_name text,
  donor_city text,
  donor_state text,
  donor_zip_code text,
  donor_employer text,
  donor_occupation text,
  donor_organization text,
  donor_industry text,
  donor_entity_type text,
  donor_committee_id text,
  donor_committee_name text,
  donor_committee_type text,
  donor_committee_party text,
  primary key (transaction_id)
);

insert into trg_analytics.candidate_contributions

select
  transaction_id,
  transaction_type,
  election_cycle,
  election,
  primary_general_indicator,
  transaction_date,
  transaction_amount,
  filed_date,
  recipient_committee_name,
  recipient_candidate_name,
  recipient_candidate_party,
  recipient_candidate_ico,
  recipient_candidate_status,
  recipient_candidate_office,
  recipient_candidate_district,
  donor_name,
  donor_city,
  donor_state,
  donor_zip_code,
  donor_employer
  donor_occupation,
  donor_organization,
  donor_industry,
  donor_entity_type,
  donor_committee_id,
  donor_committee_name,
  donor_committee_type,
  donor_committee_party
from stg_analytics.stg_candidate_contributions
;
