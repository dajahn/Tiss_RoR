class ProjectController < SearchController
    def index
        search_type = {
            "model" => "Project",
            "search_term" => "Project name"
        }
        super(search_type)
    end

    def search
        @query = query_param
        @results = super("https://tiss.tuwien.ac.at/api/search/projectFullSearch/v1.0/projects?searchterm=" + @query)
    end

    private

    def query_param
        params.require(:query)
    end 
end