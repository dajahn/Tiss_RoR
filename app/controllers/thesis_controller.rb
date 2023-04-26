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

    def details
        thesis_id = params.require(:id)
        @doc = super("https://tiss.tuwien.ac.at/api/thesis/#{thesis_id}")
        logger.info @doc.at_xpath("//title/de").content

        logger.info @doc.at_xpath("//instituteName/de").content
        logger.info @doc.at_xpath("//advisor/givenName").content
        logger.info @doc.at_xpath("//advisor/familyName").content
        logger.info @doc.at("//thesisType").content
    end

    private

    def query_param
        params.require(:query)
    end 
end