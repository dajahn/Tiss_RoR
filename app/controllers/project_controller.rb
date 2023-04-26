require 'nokogiri'
require 'open-uri'
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

    def details
        project_id = params.require(:id)
        @doc = super("https://tiss.tuwien.ac.at/api/pdb/rest/project/v3/#{project_id}")

        logger.info @doc.at("shortDescription").content
        logger.info @doc.at_xpath("//title/de").content
        logger.info @doc.at_xpath("//abstract/de").content
        logger.info @doc.at_xpath("//projectForm").content
        logger.info @doc.at_xpath("//keywords/keyword/de").content
    end

    private

    def query_param
        params.require(:query)
    end 
end