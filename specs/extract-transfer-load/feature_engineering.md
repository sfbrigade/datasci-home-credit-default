# Spec Name: Feature Engineering

## Goals
The goal of this project will be take the election results and campaign finance transaction data that we already have in our database, and perform "Feature Engineering". In this context Feature Engineering refers to taking the data and performing transformations to derive additional useful features from the dataset. For example, if we were looking at campaign finance transaction data, one useful derivation of `donor_name` would be to classify the donor as an "individual" vs. "organization".

## Resources
This project will mostly require data science and data engineering resources. In addition, general domain knowledge about election processes in California will be immensely helpful (i.e. anyone who is interested please help!) 

## Dates
We estimate that this project should take about three weeks.

1. Start Date: 2018-02-07
2. Estimated End Date: 2018-02-28
3. Actual End Date: 

## Background and Significance (why are we doing this?)
Although we already have campaign finance and election results data, by enriching our dataset with more colorful features, it allows us to examine the data in more granularity which will improve the overall state of our dashboard and analysis models.

## Definition of Done

**MVP (Minimal Viable Product) Requirements:**
At a minimum, we should be able to at least 

1. For a particular campaign finance transaction:
    1. Can we say classify the donor as an individual vs organization?
    2. If organization, can we classify which industry?
    3. Can we classify out-of-state donations?
    4. Can we classify "Small Money" Donors
2. To combine the campaign finance transaction data and election results data we don't have a universal `candidate_id`. Conduct a fuzzy merge based on name to connect the two data sources.

**Beyond MVP**
Feature Engineering can, in theory, go on indefinitely. With any given data set, we could come up with infinite transformations and derivations to add additional features. The point of this spec is to list the minimum additional features to make our analysis and visualizations more useful.

That being said, there are potentially useful extensions of the MVP above (and feel free to add/change these as necessary!) Some might include:

1. We will be working with a variety of different data sources and we will probably be frequently joining on names (e.g. political candidate). Unfortunately, there doesn't seem to be a universal identifier across all data sets and we will have to rely on names.
    1. While "fuzzy merges" might work for one-off tasks, it would be great if we could think about a more robust solution (perhaps create our own C4SF universal identifier?)
    2. In addition (or alternatively) can we write a task to standardize names?
2. Are there other meaningful features about the candidate we can pull in? For example, are they independently wealthy? If so, does that mean their sources of funding are more obscure?
3. For election results:
    1. Can we identify which were "close" elections or a-priori did not have a heavy favorite?

## External Citations

## Out of Scope
