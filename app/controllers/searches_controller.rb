class SearchesController < ApplicationController
  def new
  	@search = Search.new
  end

  def create
    @search = Search.new(params[:search])
  	@search.date = Date.strptime(params[:search][:date],"%m/%d/%Y").to_time
    @search.start_time = TIMES[params[:search][:start_time]]
    @search.end_time = TIMES[params[:search][:end_time]]
    @search.save
    redirect_to @search
  end

  def show
  	@search = Search.find(params[:id])
  end
end