class SearchesController < ApplicationController
  def new
  	@search = Search.new
  end

  def create
    @search = Search.new(params[:search])
  	@search.date = Date.strptime(params[:search][:date],"%m/%d/%Y").to_date if params[:search][:date] != ""
    @search.start_time = TIMES[params[:search][:start_time]]
    @search.end_time = TIMES[params[:search][:end_time]]
    if @search.save
      redirect_to search_path(@search)
    else
      render 'new'
    end
  end

  def show
  	@edit_search = Search.find(params[:id])
    @show_search = @edit_search
    @sfiltered = @show_search.specials
  end

  def edit
  end

  def update
    @search = Search.find(params[:id])
    params[:search][:date] = Date.strptime(params[:search][:date],"%m/%d/%Y").to_date if params[:search][:date] != ""
    params[:search][:start_time] = TIMES[params[:search][:start_time]]
    params[:search][:end_time] = TIMES[params[:search][:end_time]]
    if @search.update_attributes(params[:search])
      redirect_to search_path(@search)
    else
      @edit_search = @search
      @show_search = @search
      render 'show'
    end
  end
end
