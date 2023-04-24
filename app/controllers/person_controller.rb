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

    private

    def query_param
        params.require(:query)
    end
end