class PersonController < SearchController

    def index
        
    end

    def search
        @query = query_param
        @results = super("https://tiss.tuwien.ac.at/api/person/v21/psuche?q=" + @query)
        puts @results
    end

    private

    def query_param
        params.require(:query)
    end
end