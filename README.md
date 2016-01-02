# HackersBlog

This is an application that aggregates and displays the articles from various engineering blogs taken from [Kilimchoi Engineering Blogs](https://github.com/kilimchoi/engineering-blogs ). It displays the articles sorted by number of views from this app, with the latest articles displayed first.

### Usage:

Migrate to the database using:

`rake db:migrate`

Run the required rake tasks as follow:

`rake feeds:update_feeds`

This will crawl the [ OPMl file](https://raw.githubusercontent.com/kilimchoi/engineering-blogs/master/engineering_blogs.opml) using wombat and register all the feeds for tracking

`rake articles:initialise_articles`

This will parse the feeds and get all current articles into the database

`rake articles:update_articles`

This will update the articles from all the feeds after the previous update. Should be run periodically
