namespace :articles do


require 'logger'
require 'feedjira'

def parse_feed(url,log)
  begin
  feed = Feedjira::Feed.fetch_and_parse url
  log.info "#{url} :"
  log.info "Success"
  return feed
  rescue Feedjira::NoParserAvailable=>e
      log.error e.message
  rescue Feedjira::FetchFailure=>e
      log.error "Unable to fetch #{url}"
  rescue Exception=>e
        log.error e.message
  end
  return nil
end

  desc "TODO"
  task initialise_articles: :environment do
    log=ActiveSupport::Logger.new('log/initialise_articles.log')
    start_time=Time.now
    log.info "Started task initialise_articles at #{start_time}"
    blogs=Blog.all
    blogs.each do |blog|
      feeds=parse_feed(blog.feed_url,log)
      if(!feeds.nil?)
        feeds.entries.each do |item|
          if(blog.articles.find_by(title: item.title).nil?)
            article=blog.articles.new
            article.title=item.title
            article.url=item.url
            article.published=item.published
            article.views=0
            article.save
          end
        end
      end
    end
    end_date=Time.now
    log.info "Finished at #{end_date}"
  end

  desc "TODO"
  task update_articles: :environment do
    log=ActiveSupport::Logger.new('log/update_articles.log')
    start_time=Time.now
    log.info "Started task update_articles at #{start_time}"
    blogs=Blog.all
    blogs.each do |blog|
      last_item=blog.articles.order(published: :desc).limit(1)
      feeds=parse_feed(blog.feed_url,log)
      if(!feeds.nil?)
        feeds.entries.each do |item|
          if(item.title.nil?)
            next
          end
          if(!last_item.empty?&&item.title==last_item[0].title)
            break
          end
            article=blog.articles.new
            article.title=item.title
            article.url=item.url
            article.published=item.published
            article.views=0
            if Rails.env.production? && !article.published.nil?
            article.save
            if Blog.count+Article.count >10000
              last=Article.order("published ASC NULLS FIRST").first
              last.delete
            end
          elsif !Rails.env.production?
              article.save
          end
        end
      end
    end
    end_date=Time.now
    log.info "Finished at #{end_date}"
  end

end
