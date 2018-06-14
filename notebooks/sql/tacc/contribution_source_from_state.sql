-- https://modeanalytics.com/editor/code_for_san_francisco/reports/9b612f447429
-- Query 1
-- The user enters the recipient_candidate_name.
-- This displays the election cycle, number of contributions for each 
-- election cycle per state, the contribution amount, and the average amont of contributions.
-- This assist users with identifying which state, including Washington DC, is donating to the candidate.

select 
  recipient_candidate_name,
  election_cycle,
  count(*) as num_contrib,
  regexp_replace(upper(donor_state), '[^A-Z]', '' , 'g')  as candidate_donor_states,
  sum(transaction_amount)  as state_transaction,
        --DECLARE @money money = '125000';
        --SELECT FORMAT ( @money, 'C', 'en-US'  ) AS MyMoney;
  sum(transaction_amount) / count(*) as avg_$_per_contribution
  
from trg_analytics.candidate_contributions
where  regexp_replace(upper(donor_state), '[^A-Z]', '' , 'g') in ( 
    'AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY'
) 
  and recipient_candidate_name like '%BROWN, EDMUND G. (JERRY)%'
group by recipient_candidate_name, election_cycle, candidate_donor_states
order by election_cycle desc
