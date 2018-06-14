# Data Scavenger Hunt
This "Data Scavenger Hunt" will walk you through a list of questions that will help you explore the data and the structure of our database. Before going through the data scavenger hunt, we strongly recommend that you complete the [onboarding](../onboarding) steps as well.

To complete the Data Scavenger Hunt, you can either use:

1. [Mode Analytics:](https://modeanalytics.com/home/code_for_san_francisco/search) Mode Analytics is an online application that allows the user to access our database and write SQL queries or Python notebooks to explore and analyze the data. Mode Analytics has lots of useful features and is a quick way to access the database without necessarily going through all the overhead associated with setting up your [development environment](../onboarding/02_development_environment.md). 
2. Jupyter Notebook: You can also create your own Jupyter notebook and use Python to answer the questions. If you choose to go this route, you will have to set up your [development environment](../onboarding/02_development_environment.md) and get access to the database credentials to connect to the database. If you do not already have the database credentials, please ping our Slack Channel (#datasci-congressdata) and/or ask a project lead.

If you would like to save your work and push to this repository, you can! To do this, create a new folder in the [submissions](./submissions) folder titled with your name and save any relevant files in your folder!

Lastly, before getting started if you haven't had prior experience using SQL and/or Python for data analysis, Mode Analytics' [Tutorial for Data Analysis](https://community.modeanalytics.com/sql/tutorial/introduction-to-sql/) is a great way to get started. This tutorial both has SQL and Python lessons and is a great way to get accustomed to Mode Analytics as an application to query our databases.

## Questions
To complete these questions, use the table `trg_analytics.candidate_contributions`. This table is a list of contributions made to Candidates and Other Committees in California.

1. How many rows are in `trg_analytics.candidate_contributions`?
2. What is the total sum of donations made to candidates in the 2017-2018 election cycle?
3. Across history what are the top 5 zip codes ranked according to the donations sourced from those areas? Which cities are these zip codes located in? Do you notice anything surprising?
4. In the 2015-2016 election cycle, which candidate received the most donations?
5. For the candidate you found in question (4) above, who was their highest contributing donor?
6. In the 2017-2018 election cycle, how many donors comprised of 50% of all donations made?
7. Repeat (6) for all the other election cycles (currently the dataset includes election cycles starting in 2001). Does the number of donors who comprise of 50% of all donations made within each election cycle change over time?
8. What is the total sum of donations that are 'LOANS' in 2017-2018?

Explore the data independently and report one additional finding you think is interesting!
