class EntriesController < ApplicationController
  def show
    @entry = Entry.find params[:id]
    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml => @entry }
    end
  end
end
