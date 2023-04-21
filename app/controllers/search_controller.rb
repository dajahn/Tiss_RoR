require 'net/http'
require 'json'

class SearchController < ApplicationController

    def index
        puts "Hello World"
    end

    def search (query)
        uri = URI(query)
        response = Net::HTTP.get(uri)
        my_hash = JSON.parse(response)
        for i in 0..my_hash["results"].count-1
            puts my_hash["results"][i]["id"]
        end

        render 
    end

end