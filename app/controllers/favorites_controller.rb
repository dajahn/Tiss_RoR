class FavoritesController < ApplicationController



  def list

    @parameters = {
      "listName" => params[:listName],
    "paramName" =>params[:paramName],
    "order" => params[:order]
    }

    if @parameters["order"].nil?
      @parameters["order"] = "desc"
    end
    unless ["title", "created_at"].include? @parameters["paramName"]
      @parameters["paramName"] = "title"
    end

    unless ["person", "thesis", "course", "project"].include? @parameters["listName"]
      @parameters["listName"] = "person"
    end

    @result = Favorite.where(entryType: @parameters["listName"]).order( @parameters["paramName"]+" "+  @parameters["order"])
    if @parameters["listName"] == "course"
      courses = Favorite.where(entryType: "course").to_a
      # courses.each do |res|
      #   puts res["title"]
      #   res["semester"] = get_semester_from_course_name(res["title"])
      # end
      @result = courses
    end

  end


  def get_semester_from_course_name(name)
    matches = name.match /(\d*[W|S])/
    matches[1]
  end


end