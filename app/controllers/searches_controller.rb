class SearchesController < ApplicationController
  def new
  	@search = Search.new
  end

  def create
    @search = Search.new(params[:search])
  	@search.date = Date.strptime(params[:search][:date],"%m/%d/%Y").to_date
    @search.start_time = TIMES[params[:search][:start_time]]
    @search.end_time = TIMES[params[:search][:end_time]]
    @search.save
    redirect_to search_path(@search)
  end

  def show
  	@edit_search = Search.find(params[:id])
    @edit_search.date = @edit_search.date.strftime("%m/%d/%Y")
    @edit_search.start_time = TIMES.key(@edit_search.start_time)
    @edit_search.end_time = TIMES.key(@edit_search.end_time)
    @show_search = Search.find(params[:id])
  end

  def edit
    #@search = Search.find(params[:id])
    #@search.date = @search.date.strftime("%m/%d/%Y")
    #@search.start_time = TIMES.key(@search.start_time)
    #@search.end_time = TIMES.key(@search.end_time)
  end

  def update
    @search = Search.find(params[:id])
    params[:search][:date] = Date.strptime(params[:search][:date],"%m/%d/%Y").to_date
    params[:search][:start_time] = TIMES[params[:search][:start_time]]
    params[:search][:end_time] = TIMES[params[:search][:end_time]]
    @search.update_attributes(params[:search])
    redirect_to search_path(@search)
  end
end