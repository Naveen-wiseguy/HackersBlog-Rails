namespace :feeds do
  require 'wombat'
  require 'logger'
  # A helper function to retrieve RSS feeds from the specified OPML file as a hash
  #Params:
  #  +url+:: Base URL of the path containing the OPML file
  #  +url_path+:: Path of the OPML file relative to the base URL. Should begin with a '/'
  def getFeeds(url,url_path)
   x = Wombat.crawl do
    base_url url
    path url_path
    document_format :xml
    feeds "xpath=//body/outline/outline[@type='rss']" , :iterator do
      name "xpath=./@title"
      feedURL "xpath=./@xmlUrl"
      htmlURL "xpath=./@htmlUrl"
    end
    end
    x["feeds"]
  end


  desc "Update the feeds list and URLS from the Kilimchoi blogs OPML file"
  task update_feeds: :environment do
    log=ActiveSupport::Logger.new('log/update_feeds.log')
    start_time=Time.now
    log.info "Started task update_feeds at #{start_time}"
    x=getFeeds("https://raw.githubusercontent.com","/kilimchoi/engineering-blogs/master/engineering_blogs.opml")
    x.each do |feed|
      log.info "Found feed at #{feed['name']}"
      if Blog.find_by( name: feed["name"]).nil?
        blog=Blog.new
        blog.name=feed["name"]
      else
        log.info "Feed already exists .... Updating"
        blog=Blog.find_by( name: feed["name"])
      end
      blog.feed_url=feed["feedURL"]
      blog.url=feed["htmlURL"]
      blog.save
    end
    end_date=Time.now
    log.info "Finished at #{end_date}"
  end

end
