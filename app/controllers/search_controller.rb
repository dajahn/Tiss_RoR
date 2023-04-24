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

        render :list
    end
end