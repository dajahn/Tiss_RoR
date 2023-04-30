class PersonController < SearchController

    def index
        search_type = {
            "model" => "Person",
            "search_term" => "Name"
        }
        super(search_type)
    end

    def search
        @query = query_param
        @results = super("https://tiss.tuwien.ac.at/api/person/v21/psuche?q=" + @query)
    end

    def details
        id = params.require(:id)
        uri = URI("https://tiss.tuwien.ac.at/api/person/v22/id/#{id}")
        response = Net::HTTP.get(uri)
        @person = JSON.parse(response)
        @links_query = "#{@person["first_name"]}+#{@person["last_name"]}"
        @isFav = isFav()
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

    def query_param
        params.require(:query)
    end
end