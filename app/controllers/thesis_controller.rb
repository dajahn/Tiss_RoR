class ThesisController < SearchController
    def index
        search_type = {
            "model" => "Thesis",
            "search_term" => "Thesis name"
        }
        super(search_type)
    end

    def search
        @query = query_param
        @results = super("https://tiss.tuwien.ac.at/api/search/thesis/v1.0/quickSearch?searchterm=" + @query)
    end

    private

    def query_param
        params.require(:query)
    end 
end