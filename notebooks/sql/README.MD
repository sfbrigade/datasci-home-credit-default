#### Main merge statement and display.

[https://modeanalytics.com/editor/code_for_san_francisco/reports/23fa56dfb4eb](https://modeanalytics.com/editor/code_for_san_francisco/reports/23fa56dfb4eb)

* Query 1 - Produces candidate_name, contributions, and winner from both tacc_ and dicccser_ data.<br>
    campaign_finance_and_election_results.sql

#### The current match rate as of 04.08.2018 and a link to Mode Analytics workspace verifying the SQL statements.

[https://modeanalytics.com/editor/code_for_san_francisco/reports/d4e007734c45](https://modeanalytics.com/editor/code_for_san_francisco/reports/d4e007734c45)

* Query 1 -  142 distinct candidate_name matches with regular expression.<br>
   distinct_candidate_name_matches_with_re_from_tacc_and_dicccser.sql

* Query 3 -  1550 recipient_candidate_name with regular expression.<br>
   distinct_recipient_candidate_name_with_re_from_tacc.sql

* Query 5 -  225 candidate_names with regular expression.<br>
   total_number_distinct_candidates_with_re_from_dicccser.sql

* Query 21 - 230 distinct candidate_name with no regular expression.<br>
   distinct_candidate_name_with_no_re_from_dicccser.sql

* Query 22 - 1563 distinct recipient_candidate_name with no regular expression.<br>
   distinct_recipient_candidate_name_with_no_re_ from_tacc.sql

> 142/225 =  0.631 match rate

#### Feature Engineering and Client Mock Data Source

[https://modeanalytics.com/editor/code_for_san_francisco/reports/c3783be244d1](https://modeanalytics.com/editor/code_for_san_francisco/reports/c3783be244d1)

* alpha_sql_main - This provides the average campaign contribution per election cycle for every contest name of the candidate from 2010 to 2016 General Election in California as a future source of feature selections when the name matching accuracy increases. Also, it makes available feature selections to be used data model visualizations and supplies the client side a source of mock data as a raw SQL or exported as a csv file. Its current accuracy based on the data is 0.52, contains 130 rows, and has 11 features.


* Query 10 – This is a variation of the alpha_sql_main that includes all the features from both the dicccser and tacc tables. 


#### Workspace Abbreviations

* trg_analytics.candidate_contributions => tacc_
 
* data_ingest.casos__california_candidate_statewide_election_results => dicccser_

* regular expression => re_
