-- alhpa_main_sql: This provides available feature selections to be used data model visualizations and supplies the client side a source of mock data as a raw SQL or exported as a csv file. It contains 130 rows, with 11 features including:

-- cn : candidate name: first last
-- rcn_tacc :  the regular expression output of recieptant candidate name from the trg_analytics.candidate_contributions table
-- party_name : candidate’s party
-- election year:  general election year. Note: the election cycle from the campaign contributions is adjusted to the general election cycle.
-- contest_name : candidate’s office for election
-- total_votes: election’s total votes for the candidiate
-- incumbent_flag: candidate’s status of holding the office prior to the election
-- is_winner: 0= lost, 1= winner – candidate election result
-- average_amount_per_contrib:  average amount of money per campaign contribution
-- num_trans: total number of campaign contributions for that election
-- total_contrib: total amount of campaign contributions for that election


with t1 as ( --cadidate_contribution_per_election_cycle
  select 
      recipient_candidate_name as rcn,
      election_cycle as ec,
      sum(transaction_amount) as trans_amount,
      count(*) as num_trans
  from trg_analytics.candidate_contributions
  where cast(election_cycle as int) >= 2009 -- The election cycle year has to match the dicccser table election year time interval as to obtian the election results.
  group by recipient_candidate_name, election_cycle
),

t2 as (
  select
    replace( candidate_name, '*', '') as cn,
    party_name,
    election_name,
    contest_name,
    sum(vote_total) as total_votes,
    incumbent_flag,
    rank() over (partition by election_name,  contest_name  order by sum(vote_total)  desc)  = 1 as is_winner
  from data_ingest.casos__california_candidate_statewide_election_results
  where county_name like 'State Totals' 
    and contest_name not like 'President%'
    and contest_name not like 'president%'
    and contest_name not like 'US Senate%' 
    and contest_name not like 'United States Representative%'
    and contest_name not like 'us'
    and contest_name not like 'united%'
    and contest_name not like '%Congressional District'
  group by 
    candidate_name,
    party_name,
    contest_name,
    election_name,
    incumbent_flag
),

t2_a as (
  select 
    t2.cn,
    regexp_replace(lower(split_part(t2.cn, ',', 2) || split_part(t2.cn, ',', 1)), '[^a-z]', '', 'g') as cn_dicccser,
    party_name,
    cast(SUBSTRING( election_name, 1, 4) as int) as election_year,
    contest_name,
    total_votes,
    incumbent_flag,
    is_winner::int as is_winner
  from t2
 ),   
 
t1_a as (
  select 
      t1.rcn,
      regexp_replace(lower(split_part(rcn, ',', 2) || split_part(rcn, ',', 1)), '[^a-z]', '', 'g') as rcn_tacc,
      --t1.rcn_tacc,
      cast( t1.ec as int)+1 as election_year,
      round(trans_amount/ num_trans, 2) as average_amount_per_contrib,
      t1.num_trans,
      t1.trans_amount as total_contrib
  from t1
)

select 
    cn,
    rcn_tacc,
    party_name,
    t1_a.election_year,
    contest_name,
    total_votes,
    incumbent_flag,
    is_winner,
    average_amount_per_contrib,
    num_trans,
    total_contrib
from t2_a 
join t1_a
on cn_dicccser = rcn_tacc
and t2_a.election_year = t1_a.election_year
order by t2_a.election_year, t2_a.contest_name


