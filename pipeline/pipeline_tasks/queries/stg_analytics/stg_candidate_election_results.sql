/*
This query combines various sources of candidate election results.

Currently, the table only has California candidate election results sourced from CEDA
*/

drop table if exists stg_analytics.stg_candidate_election_results;
create table stg_analytics.stg_candidate_election_results
(
  record_id text primary key,
  single_county_race_id text,
  mult_county_race_id text,
  mult_county_candidate_id text,
  is_multiple_county_race boolean,
  candidate_last_name text,
  candidate_first_name text,
  county_name text,
  jurisdiction_code text,
  jurisdiction_code_description text,
  election_year int,
  election_date date,
  political_jurisdiction text,
  is_csd boolean,
  office text,
  office_code text,
  office_code_description text,
  area_within_office text,
  term_of_office text,
  number_seats_to_be_filled int,
  candidate_ballot_designation text,
  is_incumbent boolean,
  number_candidates_running int,
  number_votes_for_candidate int,
  total_votes_for_all_candidates int,
  rank_order_of_candidates int,
  percent_of_votes_received_by_candidate numeric,
  candidate_election_outcome int,
  candidate_election_outcome_description text,  
  mult_county_number_votes_for_candidate int,
  mult_county_total_votes_for_all_candidates int,
  mult_county_rank_order_of_candidates int,
  mult_county_candidate_election_outcome int,
  mult_county_candidate_election_outcome_description text
);

insert into stg_analytics.stg_candidate_election_results

select
  record_id,
  race_id as single_county_race_id,
  multi_race_id as mult_county_race_id,
  multi_cand_id as mult_county_candidate_id,
  multi_co = 1 as is_multiple_county_race,
  last as candidate_last_name,
  first as candidate_first_name,
  cntyname as county_name,
  jur as jurisdiction_code,
  case when jur = 1 then 'county'
       when jur = 2 then 'city'
       when jur = 3 then 'school district'
       else null
  end as jurisdiction_code_description,
  year as election_year,
  date as election_date,
  place as political_jurisdiction,
  csd = 1 as is_csd,
  lower(office) as office,
  recode_office as office_code,
  recode_offname as office_code_description,
  area as area_within_office,
  term as term_of_office,
  vote_number as number_seats_to_be_filled,
  baldesig as candidate_ballot_designation,
  incumb = 'Y' or num_inc = 1 as is_incumbent,
  cand_number as number_candidates_running,
  votes as number_votes_for_candidate,
  case when totvotes = '#NULL!' then null else totvotes::numeric::int end as total_votes_for_all_candidates,
  rvotes as rank_order_of_candidates,
  percent as percent_of_votes_received_by_candidate,
  elected as candidate_election_outcome_code,
  case when elected = 1 then 'elected to office'
       when elected = 2 then 'not elected to office'
       when elected = 3 then 'runoff'
       else null
  end as candidate_election_outcome__code_description,  
  indivtotal_votes as mult_county_number_votes_for_candidate,
  newtovotes as mult_county_total_votes_for_all_candidates,
  Rindivto as mult_county_rank_order_of_candidates,
  newelected as mult_county_candidate_election_outcome_code,
  case when newelected = 1 then 'elected to office'
       when newelected = 2 then 'not elected to office'
       when newelected = 3 then 'runoff'
       else null
  end as mult_county_candidate_election_outcome_description
from data_ingest.ceda__california_candidate_local_election_results
;
