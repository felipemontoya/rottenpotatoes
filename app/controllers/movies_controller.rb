require 'pp'

class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    #HW3
    @all_ratings = Movie.ratings
    
    @used_ratings = params[:ratings]
    
    if (params[:ratings] != nil)
        ratings = params[:ratings].keys
        query_rating_params = {:rating => ratings}
    else
        query_rating_params = {}
        @used_ratings = Hash[@all_ratings.map {|v| [v,1]}]
    end
        

    #HW2
    @myString = params
	@th_title_class = "normal"
	@th_release_date_class = "normal"

    @mySortString = ""
	if (params[:ratings])
	    params[:ratings].each do |rat| 
	        @mySortString << "&ratings[" << rat[0] << "]=" << rat[1]
	    end
	end
	
	case params[:sort]
    when "title"
        @myString ="title"
        @movies = Movie.where(query_rating_params).order("title ASC")
        @th_title_class = "hilite"
    when "release date"
        @myString ="release date"
        @movies = Movie.where(query_rating_params).order("release_date ASC")
        @th_release_date_class = "hilite"
    else
        @movies = Movie.where(query_rating_params)
    end
    
    
    #test: should not be there, because it overrides everything
#        @movies = Movie.where({}).order("title ASC")
#        @movies = Movie.where(:rating => ['R']).order("title ASC")

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
