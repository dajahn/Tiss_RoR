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
    @result = {
      "title" => @doc.at_xpath("//shortDescription").content,
      "subtitle" => "#{@doc.at_xpath("//title/de").content}",
      "subsubtitle" => "Projektform: #{@doc.at_xpath("//projectForm").content}, Projekttyp: #{@doc.at_xpath("//projectType").content}",
      "text" => @doc.at_xpath("//abstract/de") ? @doc.at_xpath("//abstract/de").content : nil,
      "text_2" => "Projektbeginn: #{@doc.at_xpath("//projectBegin").content}, Projektende: #{@doc.at_xpath("//projectEnd").content}"
    }
  end

  private

  def query_param
    params.require(:query)
  end
end