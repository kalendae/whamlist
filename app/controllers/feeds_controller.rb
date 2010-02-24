class FeedsController < ApplicationController
  include AuthenticatedSystem
  before_filter :login_required, :only => [:index]

  # GET /feeds
  # GET /feeds.xml
  def index
    @feed = Feed.new
    @recent_feeds = Feed.recent 20

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /feeds/1
  # GET /feeds/1.xml
  def show
    @feed = Feed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feed }
    end
  end

  # POST /feeds
  # POST /feeds.xml
  def create
    # first does this feed already exist
    @feed = Feed.find_by_feed_url(params[:feed][:feed_url])

    # if not create a feed obj
    if @feed.blank?
      @feed = Feed.new(params[:feed])
      begin
        f = FeedTools::Feed.open(params[:feed][:feed_url])
        @feed.title = f.title
        @feed.submitter = current_user
        @feed.save!
        flash[:notice] = 'Feed was successfully created.'
      rescue Exception => e
        flash[:error] = e.message
      end
    else
      flash[:notice] = "Feed was first submitted by #{@feed.submitter} and has now been added to your feed list." 
    end

    # add this feed to the current user
    current_user.feeds << @feed unless @feed.blank? or @feed.submitter.blank?

    respond_to do |format|
      format.js
    end
  end

  # PUT /feeds/1
  # PUT /feeds/1.xml
  def update
    @feed = Feed.find(params[:id])

    respond_to do |format|
      if @feed.update_attributes(params[:feed])
        flash[:notice] = 'Feed was successfully updated.'
        format.html { redirect_to(@feed) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.xml
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to(feeds_url) }
      format.xml  { head :ok }
    end
  end
end
