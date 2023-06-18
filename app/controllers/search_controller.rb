require 'net/http'
require 'json'
require 'open-uri'

class SearchController < ApplicationController
    def index(search_type)
        @search_type = search_type
    end

    def search (url)
        get_search_results(url)
 
        for i in 0..@result.count-1
            if Current.search_page_name == "course"
                params[:id] = get_course_number_from_url(@result[i]["detail_url"])
            else
                params[:id] = @result[i]["id"]
            end
            @result[i]["isFav"] = isFav()
        end

        if Current.search_page_name != "course"
            render :list
        end
    end

    def get_search_results(url)
        uri = URI(url)
        response = Net::HTTP.get(uri)
        my_hash = JSON.parse(response)
        @result = my_hash["results"]
    end

    def details (url)
        setId()
        @isFav = isFav()
        logger.info url
        call_api(url)
    end

    def call_api(url)
        @doc = Nokogiri::XML(URI.open(url))
        @doc.remove_namespaces!
    end

    def addFavorite
        super()
    end

    def removeFavorite
        super()
    end

    def isFav
        super()
    end

    def report(listname)
        @parameters = {
            "showNotes" => params[:showNotes] 
        }
  
        @favorites = Favorite.where(entryType: listname, user_id: Current.user)
    end

    private
    def setId
        @id = params[:id]
    end

    def update
        super()
    end

end