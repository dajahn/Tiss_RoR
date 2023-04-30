require 'net/http'
require 'json'

class SearchController < ApplicationController
    def index(search_type)
        @search_type = search_type
    end

    def search (query)
        uri = URI(query)
        response = Net::HTTP.get(uri)
        my_hash = JSON.parse(response)
        @result = my_hash["results"]
 
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

    def details (url)
        setId()
        @isFav = isFav()
        logger.info url
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

    private
    def setId
        @id = params[:id]
    end
end