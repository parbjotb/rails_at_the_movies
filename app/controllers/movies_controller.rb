class MoviesController < ApplicationController
  def index
    # to populate the index page for movies
    # now @movies is visible by the index view and will show movies ascending on vote count
    @movies = Movie.includes(:production_company).all.order("average_vote ASC")
  end

  def show
    # this will let the show view page access a specific movie based on id
    @movie = Movie.find(params[:id])
  end
end
