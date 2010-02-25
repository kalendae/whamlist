class EntriesController < ApplicationController
  include AuthenticatedSystem
  before_filter :login_required, :only => [:mark_as_read]

  def show
    @entry = Entry.find params[:id]
    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml => @entry }
    end
  end

  def mark_as_read
    @entry = Entry.find params[:id]
    current_user.entries << @entry unless current_user.entries.include? @entry
    respond_to do |format|
      format.js
    end
  end

end
