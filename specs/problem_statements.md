# Problem Statements
In this document we list several overall "problem statements" we are focusing on.

## Problem Statement 1: Making Campaign Finance Data more transparent
A critical issue with campaign finance data is how opaque the system is. However, this data is extremely important. Funders impact who are elected officials are and may even affect how our elected officials' voting behavior. In addition, as much work that's been done on a national level, much less has been done at a local level (e.g. SF Bay Area + Monterey Bay) *How might we aggregate this data and present it in a more accessible manner?*

In addition, [MapLight](https://maplight.org/), a non-profit org dedicated to revealing money's influence on politics, has seeded us with data and some [project ideas](https://docs.google.com/document/d/16AjCc01mT8_S_VJKovRb-hQgkGwIx5F8NNRV9jF79U4/edit?usp=sharing). MapLight is currently working on a visualization project with the CA Secretary of State to provide easily-understandable campaign finance statistics of candidates for the State office. Mockups of this effort are [here](https://drive.google.com/drive/folders/1hmZT-K-4EfGUZF1ZqntL1v0NptXv1mAA). While this project is estimated to complete around April or May, MapLight is encouraging Code for San Francisco to produce complimentary visualizations which MapLight may also host on its website!

### Challenges

1. Extract Campaign Finance Data from [Cal-Access](http://cal-access.sos.ca.gov/Campaign/), [SF Open Data](https://data.sfgov.org/City-Management-and-Ethics/Campaign-Finance-Database/sv2b-bdbj), and/or [Map Light](https://maplight.org/data_guide/bulk-data-sets-and-apis/) and parse into a usable format (e.g. relational database). This will be very related, if not identical, to the work necessary to complete Problem Statement 2.
2. Visualize data on a public website/dashboard.
    1. For each election cycle/candidate can we show how much each candidate has received from which sources?
    2. Can we show how much was received at a geographic level?
    3. Do outsiders with money have an undue influence?  How much money in campaigns comes from outside a candidate’s district, and what is a good way to display that relationship?
    4. Is there a good visualization to show which candidates have a lot of grassroots support (many small donations) compared to candidates with a small number of wealthy backers?
    5. Is there a relationship between having more money and winning elections?  In competitive elections, does the candidate with more money tend to win?

Some prior art from Code for San Francisco (2016 election cycle): https://github.com/sfbrigade/campaign_finance

## Problem Statement 2: Predicting Voting Behavior and Election Results Based on Funding Sources
The reason why more transparency in campaign finance data is critical is because, unfortunately, not every official is acting in the best interest of the American public. Money talks. Lawrence Lessig (professor at Harvard Law School) gave an inspiring [TED Talk](https://www.ted.com/talks/lawrence_lessig_we_the_people_and_the_republic_we_must_reclaim) in which he describes how only the top 0.05% of people in America actually financially contribute to poltiical campaigns, and thus exert exorbitant control over our political system. *How can we dive deeper into understanding the link between campaign funding sources and voting behavior? Can we use a model to predict an official's voting behavior and see how it differs from their stated/actual voting behavior?*

### Challenges

1. Extract Campaign Finance Data from [Cal-Access](http://cal-access.sos.ca.gov/Campaign/), [SF Open Data](https://data.sfgov.org/City-Management-and-Ethics/Campaign-Finance-Database/sv2b-bdbj), and/or [Map Light](https://maplight.org/data_guide/bulk-data-sets-and-apis/) and parse into a usable format (e.g. relational database). This will be very related, if not identical, to the work necessary to complete Problem Statement 1.
2. Find source of data for elected officials' voting behavior on bills in California. Then, extract this data and parse into a usable format (e.g. relational database)
    1. For example: https://www.couragescore.org/, although I'm not sure how reliable this specific one is
3. In addition, find election results and extract this data and parse into a usable format. 
4. Build a predictive model that combines campaign finance data with voting records to see how tightly related funding sources are with voting behavior. Also, build a predicting model to predict election results (who wins) based on funding sources.
    1. This may eventually also include combining other sources of data (e.g. demographic data at the zip code level)

## Problem Statement 3: Help Californians Understand Who is Behind Their Ballot Measures

The State of California keeps accurate data on the funders behind each statewide ballot measure.  The State’s Fair Political Practices Commission (FPPC) analyzes campaign filings related to ballot measure funding and [produces lists](http://www.fppc.ca.gov/transparency/top-contributors.html) of the top 10 contributors to each ballot measure.  Those lists are curated by dedicated analysts, making them more accurate than anything you can find in the [raw data](http://www.sos.ca.gov/campaign-lobbying/cal-access-resources/raw-data-campaign-finance-and-lobbying-activity/) or in [campaign finance searches](http://powersearch.sos.ca.gov/quick-search.php).

The [Quick Guide to Props](https://quickguidetoprops.sos.ca.gov/propositions/2016-11-08) provides visitors with a quick glance into what each ballot measure will do and the money supporting and opposing each measure.  This can be especially helpful when evaluating competing ballot measures that are both addressing the same topic - like [Prop 65](https://quickguidetoprops.sos.ca.gov/propositions/2016-11-08/65) and [Prop 67](https://quickguidetoprops.sos.ca.gov/propositions/2016-11-08/67) in 2016 that both proposed changes to policies around plastic grocery bags.  Knowing which measure is sponsored primarily by plastics corporations can help voters decide by evaluating how often their interests typically align with plastics companies.

Due to some issues with the source data, it doesn’t show the top contributors to each ballot measure.  Instead, it shows the largest individual contributions.  This is often the same list, but there are scenarios where the current display misses the largest contributors or significantly underestimates their involvement.

### Resources

1. The Quick Guide to Props is an open source project available in [GitHub](https://github.com/maplight/ca-ballots).
2. The tools to search through [campaign contributions](https://github.com/maplight/CAPS) and [independent expenditures](https://github.com/maplight/independent-expenditure-search) in California are also both open source projects in GitHub.
3. The Quick Guide to Props is only available for statewide ballot measures - there is no equivalent for local measures.

### Challenges

1. Build a tool that can scrape the top contributor lists for each ballot measure from the FPPC website.  Bonus points if you can work with their team to publish the data in machine-readable format on their website, but getting an agency to change its workflow can be difficult.
2. Adapt the Quick Guide to Props to show top contributors for statewide ballot measures, not the largest individual transactions.
3. Create a Quick Guide to Props for your own region.  This would require you to find machine-readable access to ballot measure campaign finance data in your region.  MapLight may be able to give you a few pointers on where to look, but wouldn’t be able to devote in-depth research to verify accuracy.  However, if you are able to use NetFile’s [API](https://cal-access.com/#/) to power your propositions guide, it should theoretically be applicable to dozens of cities and counties in CA.

## Related Works
In this section, we'll document other people's works around campaign finance that may serve as inspiration for ours:

1. Predicting US Federal Campaign Contributions using Demographic Data at the Zip code level: https://github.com/tejeffers/MoneyTalks
2. 2015 Code for San Francisco Campaign Finance Blog: http://codeforsanfrancisco.org/blog/post/April-12-2015-Campaign-Finance-Summit
3. Explore Campaign Finance: http://www.explorecampaignfinance.com/. Website for visualizing campaign finance contributions for federal level politicians.
4. The Influence of Campaign Contributions on the Legislative Process: https://scholarship.law.duke.edu/cgi/viewcontent.cgi?article=1088&context=djclpp. (Academic Paper)
5. Financing Direct Democracy: Revisiting the Research on Campaign Spending and Citizen Initiatives: http://www.nber.org/papers/w16356 (Academic Paper)

## Some Other Notes
1. Which districts are contestable? ballotpedia is a potential source
2. How does campaign finance impact incumbent advantage? Can I be alerted if some out of money can influence the outcome of an advantage?
3. Can we predict the probability of a candidate winning based on funding? If so can we build a cool web application that shows amount of money necessary (e.g. kickstarter) to push candidate over 50% of winning?
