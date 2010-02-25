class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  before_filter :login_required, :only => [:show]
  
  # users/show is the partial that displays all the articles in the feed
  def show
    flash[:notify] = ""
    @entries = []
    current_user.feeds.each do |feed|
      begin
        # only go grab a feed if its been a day since last update or it just got created
        if feed.last_grab.nil? or Time.now - feed.last_grab > 1.day
          f = FeedTools::Feed.open(feed.feed_url)
          f.items[0..4].each do |item|
            entry = Entry.find_by_feed_id_and_link(feed.id, item.link)
            if entry.blank?
              entry = Entry.new(:feed_id => feed.id, :link => item.link, :published => item.published,
                      :title => item.title, :content => item.content)
              entry.save!
            end
            @entries << entry
          end
          feed.last_grab = Time.now
          feed.save!
        else
          @entries += feed.entries.sort_by{|e| e.published.nil? ? Time.at(0) : e.published}.reverse[0..4]
        end
      rescue Exception => e
        flash[:notify] += "unable to retrieve feed for #{feed.title} due to #{e.message}<br/>"
        @entries << nil
      end
    end
    @entries = @entries.compact.sort_by{|e| e.published.nil? ? Time.at(0) : e.published}.reverse[0..19]
    respond_to do |format|
      format.js {render :partial => 'show'} 
      format.html {render :partial => 'show'}
    end
  end

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

end
