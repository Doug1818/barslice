class StaticPagesController < ApplicationController
  
  def home
  	@search = Search.new
  end

  def by_bar
  	@search = Search.new
  end

  def help
  end

  def about
  end

  def contact
  end
end
