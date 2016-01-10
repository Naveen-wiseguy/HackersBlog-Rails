# HackersBlog

This is an application that aggregates and displays the articles from various engineering blogs taken from [Kilimchoi Engineering Blogs](https://github.com/kilimchoi/engineering-blogs ). It displays the articles sorted by number of views from this app, with the latest articles displayed first.

Currently it has been hosted at [HackerBlogs ](http://hackerblogs.herokuapp.com)

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
### API:

The app also exposes an API at the URL `/api/v1`
#### API Endpoints:

`/api/v1/blogs`: Returns the list of all the tracker blogs and their details. The response format is as :

`{"blogs":[{"id":1,"name":"2359 Media","url":"http://engineering.2359media.net/"},
.....
]}`

`/api/v1/blogs/{id}`: Returns details of the blog of specified id. Alongn with details of the articles from that blog. The response format is :
`{"blog":{"id":3,"name":"8th Light","url":"http://blog.8thlight.com/","articles":[{"id":17,"title":"Entity Framework \u0026 Resolving Team Migration Conflicts","url":"https://blog.8thlight.com/zack-davy/2015/09/18/entity-framework-in-distributed-teams.html","published":"2015-09-18T05:00:00.000Z","views":0},
.......]}
}`

`/api/v1/articles` : Returns details of all the articles that have been tracked from all the blogs. They are sorted by number of views first and then by date published. Note that sometimes the date published might not be accurate as it has been extracted from the RSS feed.  The response format is :

`{"articles":[{"id":3834,"title":"Sometimes, It's Good to Be Shy","url":"http://wyeworks.com/blog/2015/12/15/sometimes-its-good-to-be-shy/","published":"2016-01-09T05:28:33.000Z","views":1},.....
]
}`

`/api/v1/articles/{id}`: Returns the details of the article with that id. This is not counted as a view. Views counted only on actually visiting the link via the web app. The response format is :

`{"articles":{"id":22,"title":"Rollup: How we use React.js and npm to share UI code at AdRoll","url":"http://tech.adroll.com/blog/frontend/2015/11/12/rollup-react-and-npm-at-adroll.html","published":"2015-11-12T00:00:00.000Z","views":0}}`
