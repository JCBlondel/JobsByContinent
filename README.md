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

### First approch
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


### Geocoding
Instead of using a thrid party api solution
along with [Geocoder](https://github.com/alexreisner/geocoder)
to get every continent's name
ending up with a static representation of continents with polygons.

The "geocoding chokepoint" appears to be one of the most challenging
part of this test because we need to guess the continent
from lat/lon coordinates for each job
facing 2 major problems:
- [lookup services](https://github.com/alexreisner/geocoder/blob/master/README_API_GUIDE.md) have quotas and need registration for an API key
- we want this script to be fast over 5k+ jobs
  and talking about scalability (2nd question)
  even while parallelizing: lookup services have rate limits

Moreover, no convention seems to exist around continent's names.

![](https://i.stack.imgur.com/m2fO5.png)

So current solution is that every continent can have one or many polygons
made from multiple points showing continents' borders.

Inspired from [this post](https://stackoverflow.com/questions/13905646/get-the-continent-given-the-latitude-and-longitude).

Using [Geokit](https://github.com/geokit/geokit) to manipulate polygons.

### Display in term

Using [terminal-table](https://github.com/tj/terminal-table) to display stats in the term


### Question 2: Scalability

From test instructions: "we have 100 000 000 job offers in our database, and 1000 new job offers per second"

Well, it diserve a good discussion !

For me it's like hand writing numbers on a [draw table](https://img.freepik.com/vecteurs-premium/chiffres-dessines-main-fleches-craie-tableau-noir_108905-154.jpg): You cannot be fast enough to write it all.
A better approach would be to draw a stick '|' for each one, from a prisonner's perspective.

You will need to split the load between multiple workers for this service, especialy if you plan to do more categorisation to jobs offers, such like 'country'.
You can handle it with parallelization, in multiple threads, using background jobs and other tools.

But you will end up with another problem writing the data while accessing it from outside. Such database like PostgreSQL will not let you enough time to pass a transaction at such an high rate.
In order to store data faster (puting sticks), we could rely on a datastore solution like [Redis](https://developer.redis.com/explore/what-is-redis/).
With a Redis datastore, we could output the count of the sticks by incrementing the right counter on a the service output.
Meanwhile, to store and index results we could batch those ones in chunks, to a database like PostgreSQL through an asynchrone job triggered right after incrementing the Redis datastore.
A job with a slower delay than 1000 requests per seconds.

To output the stats in frontend dashboards, Redis counters would be the primary source of thruth.

Another solution than Redis, would be using [Apache Kafka](https://kafka.apache.org/) that seems to handle those business cases.

I guess that Elixir has some advantages compared to other languages to handle such problems like this.
