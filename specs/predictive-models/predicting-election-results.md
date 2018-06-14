# Spec: Predicting Election Results Based on Funding Amounts and Sources

## Goals
We will build a predicting model that takes at the very least, uses funding sources and amounts as features to predict who wins an election.

## Resources
This will require primarily data science resources (although open to anyone interested).

## Dates

1. Start Date: 2018-02-21
2. Estimated End Date: 2018-03-14
3. Actual End Date:

## Background and Significance (why are we doing this?)
A brief description on why we want to work on this project.

## Definition of Done

1. We have a visualization (could be statically generated just using Python, R, or even Mode Analytics) that shows how likely a candidate will win based on the amount of funds they receive. We should be able to answer the question "how often does the candidate with the highest amount of funding actually win?"
    1. It would also be great to show different visualizations by different elections. Perhaps allow user to pick a particular election or election type
2. We have a statistical model that takes in as features funding amounts and sources (e.g. funding broken down by industry) and predicts whether or not the candidate wins an election. Other features can (and should) be used if appropriate, but we are first testing the significance of campaign finance. 

## Work Plan

1. Locate, parse, and load campaign finance data into our database.
    1. The MVP of this is at least done using Map Light data
2. Locate, parse, and load election results data into our database.
3. Merge Campaign Finance data with election results data
4. Create some initial summary visualizations showing the relationship between the two
5. Create a statistical model predicting if the candidate wins based on funding amounts and sources. Each row should represent a candidate-election pair. Other features besides funding sources might include: who is the incumbent, political party affiliation, etc. 

## External Citations
One really relevant paper for us is [Predicting Congressional Votes Based on Campaign Finance Data](https://people.eecs.berkeley.edu/~elghaoui/Pubs/icmla2012.pdf) which also uses Map Light data. I highly recommend reading this for prior art.

Some other relevant works are listed below:

For the Presidential elections, there are several papers/models that predict election results using Twitter Data. Some examples listed below:

1. http://cs229.stanford.edu/proj2012/ChandrasekarCharonGinet-PredictingTheUsElectionsUsingTwitterData.pdf
2. https://arxiv.org/pdf/1611.00440.pdf
3. https://www.aaai.org/ocs/index.php/ICWSM/ICWSM10/paper/download/1441/1852

## Out of Scope
