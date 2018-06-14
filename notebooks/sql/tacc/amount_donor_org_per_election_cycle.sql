-- https://modeanalytics.com/editor/code_for_san_francisco/reports/8ded661edc9a
-- Query 1
-- The recipient_candidate_name is selected by the user.
-- This produces data containing the election cycle, donors organization, 
-- the number of donations from that organization, the total contribution amount, 
-- and a scaled amount of the total contribution for the election cycle from that organization.
-- Although, the donor organization is category. 
-- Query 4 identifies them and there is an empty string to be delat with too.
-- OFF, OTH, IND, COM, RCP, PTY, SCC


with table_twelve as (
 select
    recipient_candidate_name,
    election_cycle,
    --donor_industry,
    --count(donor_industry), -- returns a numeric value( industry code )
    donor_organization,
    count(donor_organization) as num_donor_org,
    sum(transaction_amount) as trans_donor_org
  from trg_analytics.candidate_contributions
  where recipient_candidate_name like '%BROWN, EDMUND G. (JERRY)%'
  group by 
    election_cycle,
    recipient_candidate_name,
    --donor_industry,
    donor_organization
  order by election_cycle desc
),

table_thirteen as(

  select
    recipient_candidate_name,
    election_cycle,
    --count(transaction_amount) as total_num_trans,
    sum(transaction_amount) as total_trans_amount
  from trg_analytics.candidate_contributions
  where recipient_candidate_name like '%BROWN, EDMUND G. (JERRY)%'
  group by
    election_cycle,
    recipient_candidate_name
  order by election_cycle   desc
)

select 
  table_twelve.recipient_candidate_name,
  table_twelve.election_cycle,
  table_twelve.donor_organization,
  num_donor_org,
  trans_donor_org,
  ( trans_donor_org/ total_trans_amount ) as scaled_donor_org_trans
from table_twelve
join table_thirteen
on table_twelve.recipient_candidate_name   =  table_thirteen.recipient_candidate_name
  and table_twelve.election_cycle = table_thirteen.election_cycle
order by election_cycle desc
