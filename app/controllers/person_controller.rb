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
        if @calledByReport == 1
            id = @reportId
            @calledByReport = nil
            @reportId = nil
        else
            id = params.require(:id)
        end
        uri = URI("https://tiss.tuwien.ac.at/api/person/v22/id/#{id}")
        response = Net::HTTP.get(uri)
        @person = JSON.parse(response)
        @links_query = "#{@person["first_name"]}+#{@person["last_name"]}"
        @isFav = isFav()
        return @person
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

    def report
        super("person")
        @people = []
        for i in 0..@favorites.count-1
            @calledByReport = 1
            @reportId = @favorites[i]["objectId"]
            p = details
            @people.push(p)
        end
    end

    private

    def query_param
        params.require(:query)
    end
end