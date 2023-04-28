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
        if Current.search_page_name != "course"
            render :list
        end
    end

    def details (url)
        logger.info url
        @doc = Nokogiri::XML(URI.open(url))
        @doc.remove_namespaces!
    end
end