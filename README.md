# datasci-congressional-data [![Build Status](https://travis-ci.org/sfbrigade/datasci-congressional-data.svg?branch=master)](https://travis-ci.org/sfbrigade/datasci-congressional-data) [![Coverage Status](https://coveralls.io/repos/github/sfbrigade/datasci-congressional-data/badge.svg?branch=master)](https://coveralls.io/github/sfbrigade/datasci-congressional-data?branch=master)

*Development Status:* [![Build Status](https://travis-ci.org/sfbrigade/datasci-congressional-data.svg?branch=develop)](https://travis-ci.org/sfbrigade/datasci-congressional-data) [![Coverage Status](https://coveralls.io/repos/github/sfbrigade/datasci-congressional-data/badge.svg?branch=master)](https://coveralls.io/github/sfbrigade/datasci-congressional-data?branch=develop)

This project is a part of the [Data Science Working Group](http://datascience.codeforsanfrancisco.org) at [Code for San Francisco](http://www.codeforsanfrancisco.org) in collaboration with CSUMB Computer Science students who are completing their [capstone project](https://sites.google.com/a/csumb.edu/cst-499-computer-science-capstone-course/mentors-partners).  Other DSWG projects can be found at the [main GitHub repo](https://github.com/sfbrigade/data-science-wg).


#### -- Project Status: [Kicked Off!]

## Project Intro/Objective
Campaign finance in the U.S is the key to the system of corruption that has now wrecked our government. Members and candidates for Congress spend anywhere between 30% to 70% of their time raising money to get themselves (re)elected. But who and how many people actually contribute to these campaigns?

It turns out that only a tiny fraction of the 1% are actually "relevant funders" of congressional campaigns. In other words, 150,000 Americans wield enormous power over this government. Furthermore, our government is supposed to represent the public, but with so few making meaningful financial contributions, how do we know if our elected officials are not answering to special demands these "funders" make?

This challenge and the problems we face is described beautifully in Lawrence Lessig's [TED Talk](https://www.ted.com/talks/lawrence_lessig_we_the_people_and_the_republic_we_must_reclaim) in which he discusses the problems of Campaign Finance in America as the number one issue that blocks progress on every other issue.

The goals of this project are to use data and technology to (1) provide more transparency of campaign finance at the local, state, or even federal level and (2) investigate how campaign finance contributions affect elected officials' behavior. Our current problem statements can be found [here](./specs/problem_statements.md).

As an optional component to this project, Challenge.gov is currently sponsoring a [Congressional Data Competition](https://www.challenge.gov/challenge/congressional-data-competition/). The Challenge framing is actually quite broad: the goal is to create an application, website visualization, or other digital creation that helps analyze Congressional data. As an optional component, we can have as a deliverable to submit to this competition (there is a $5,000 prize)!

### Partner
* In partnership with CSUMB Computer Science students completing their capstone project, we will be analyzing Congressional data with a focus on campaign finance data.
* CSUMB CST 499 Capstone Project: https://sites.google.com/a/csumb.edu/cst-499-computer-science-capstone-course/mentors-partners
* Partner contact: Erik Eldridge, [@erikeldridge]

### Methods Used
* Inferential Statistics
* Machine Learning
* Data Visualization
* Predictive Modeling

### Technologies
* Python
* PostgreSQL
* Pandas, Jupyter
* Mode Analytics

### Overview

This project broadly decomposes into client/server and data eng/sci tasks:

![project overview](project_overview.png)

[overview diagram source](https://docs.google.com/document/d/1NORbNeboouyEvdN3PTgUAhwUjrLw1bpv7rDJSMgYTMI/edit#heading=h.1c9u8wssp8nk).

We recently extracted the [client/server code into it's own repo](https://github.com/sfbrigade/congressional-data-django) (for cloning efficiency on Travis).

The data eng/sci code is housed in this repo.

## Needs of this project

- **Project Leads** (from Code for San Francisco): We need project leads that are willing to be a point of contact for the CSUMB students and be an engaging partner in scoping out the problem. We are also considering a "Support Rotation", see proposed schedule below which would consist of a team of project leads from C4SF who will rotate each week on being the mentor.

Other Roles Include:
- frontend developers
- data exploration/descriptive statistics
- data processing/cleaning
- statistical modeling
- writeup/reporting

## Getting Started

Please go to the [Onboarding](./onboarding) docs to start contributing to this project!

## Project History

| Time        | Milestone |
|------------ |------|
| December 2017 | <ul><li>Project Formulation Problem Statements Created</li><li>Ongoing Team Recruitment</li></ul> |
| January 2018 | <ul><li>Two Student Teams from California State University Monterey Bay Join (9 Total Students)</li><li>Problem Statement Refinement</li><li>Set up Postgres DB on Microsoft Azure </li> </ul> |
| February 2018 | <ul><li>Project Pitch at Code for San Francisco Demo Night</li><li>Mock Dashboards Up on Mode Analytics</li><li>First Strawman Machine Learning Model Predicting Election Results using Campaign Finance Data produced </li><li>Begin Working on Web App</li> </ul> |
| March 2018 | <ul><li>Pitched Project at Open Data Day SF</li><li>Improvements in Underlying Data Model</li><li>Begin working on deployment of Web App </li> </ul> |

## Contributing DSWG Members

**Team Leads (Contacts) : [Full Name](https://github.com/[github handle])(@slackHandle)**

#### Code for San Francisco Support Rotation
| Week        | Name | Slack Handle |
|------------ |------|------------  |
| 01/03/2018 - 01/09/2018 | Vincent La     | @vincela14 |
| 01/10/2018 - 01/16/2018 | Erik Eldridge  | @erikeldridge |
| 01/17/2018 - 01/23/2018 | Vincent La     | @vincela14 |
| 01/24/2018 - 01/30/2018 | Vincent La     | @vincela14 |
| 01/31/2018 - 02/06/2018 | Vincent La     | @vincela14 |
| 02/07/2018 - 02/13/2018 | Vincent La     | @vincela14 |
| FUTURE DATE | YOUR NAME     | YOUR SLACK HANDLE |

#### Other Members:

|Name     |  Slack Handle   |
|---------|-----------------|
|[Full Name](https://github.com/[github handle])| @johnDoe        |
|[Full Name](https://github.com/[github handle]) |     @janeDoe    |

## Contact
* If you haven't joined the SF Brigade Slack, [you can do that here](http://c4sf.me/slack).  
* Our slack channel is `#datasci-congressdata`
* We'll use a [Trello dashboard](https://trello.com/b/POoUzZmJ/congressional-data) to organize work
* Feel free to contact team leads with any questions or if you are interested in contributing!

## Appendix
Note while the main focus of this project will be on campaign finance, there are undoubtedly other very interesting questions using congressional data. Some additional ideas include:

1. Voting patterns - How has your Congressional representative voted over time? Do any factors correlate with a yes vote? Can we predict how she’ll vote on the next bill? How confident are we in the prediction? Can we establish a voting preference profile, e.g. trained on voter recommendations, and generate an alert when a prediction conflicts with our preference?
2. Visualizing Gerrymandering - (i.e. can we show evidence of racial gerrymandering, or other illegal/unethical gerrymandering by socio-demographic splits)
