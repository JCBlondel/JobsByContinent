# JobsByContinent 

This repository is part of: [Welcome To The Jungle](https://www.welcometothejungle.com/) - Technical Test #Backend

The goal of this test is to write a script aiming to display job offers per profession category per continent, based on the data from two csv files (miscs folder)

## Test instructions

To help us review your test, Elixir or Ruby are the go to languages.
If you are not familiar with those languages, don’t worry, we will review your test with this in mind.
The goal here is to have a base to discuss and a peek of your reflection.

You have 7 days to complete the test.
But, you don’t have to allow all that time for it.
Few hours should be enough.
In general, candidates spend 5 to 10 hours on their tests.
Of course, you are free to allocate the time you judge necessary to finish your test.

- A nice git repository with commits history that will help us follow your flow.
- A readme to help us install and launch your application.
- You can add some lines to explain your train of thoughts on the ex01.
- Anything you judge is valuable for your test :)

(from miscs' pdf)

## Setup

Assuming you already have a working ruby local environment.

To launch this script, clone this repository, go within it from a terminal and type:
- `bundle install`
- `ruby run.rb`

## Train of thoughts for test resolution

In order to reach the goal of this test:
- open csv files
- iterate through chunks of professions' data:
  - merge to a stored hash 'professions' with id (key) and category_name (value)
  - add the category_name to a stored array 'categories' with unique values
- store a hash 'jobs_by_continent' with each continent from a static list as key, and a nested hash as value, made from previous categories with values set to 0
  `{ "Europe": { "Tech": 0, "Admin": 0, ... }, "Asie": { "Tech": 0, "Admin": 0, ...}, ...}`
- iterate through chunks of jobs' data:
  - process it to get the continent from coordinates with a geocoding solution (chokepoint here)
  - process it to get the matching category_name from stored professions from the id
  - increment the 'jobs_by_continent' from store with the given continent/category_name combination
- display the jobs_by_continent nested hash in the term
