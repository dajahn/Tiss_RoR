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
    if !validate_query
      index
      render :index
      return
    end
    query = query_param[:query]
    url = get_search_url(query)
    super(url)
  end

  def get_search_url(query)
    return "https://tiss.tuwien.ac.at/api/search/projectFullSearch/v1.0/projects?searchterm=" + query
  end

  def get_search_results(url)
    @results = super(url)
  end

  def details
    @id = params.require(:id)
    call_api(@id)
    extract_data()
    if(@isFav)
      element = Favorite.find_by(objectId: @id, entryType: Current.search_page_name, user_id: Current.user.id)
      @notes = element["notes"]
      @keywords = element["keywords"]
    end
  end

  def call_api(project_id)
    @doc = super("https://tiss.tuwien.ac.at/api/pdb/rest/project/v3/#{project_id}")
  end

  def extract_data
    @result = {
      "title" => @doc.at_xpath("//shortDescription").content,
      "subtitle" => "#{@doc.at_xpath("//title/de").content}",
      "subsubtitle" => "Projektform: #{@doc.at_xpath("//projectForm").content}, Projekttyp: #{@doc.at_xpath("//projectType").content}",
      "text" => @doc.at_xpath("//abstract/de") ? @doc.at_xpath("//abstract/de").content : nil,
      "text_2" => "Projektbeginn: #{@doc.at_xpath("//projectBegin").content}, Projektende: #{@doc.at_xpath("//projectEnd").content}",
      "isFav" => isFav()
    }
  end

  def addFavorite
      super()
  end

  def removeFavorite
      super()
  end

  def isFav
    @isFav = super()
  end

  def report
    super("project")
    @elements = []
    for i in 0..@favorites.count-1
        @reportId = @favorites[i]["objectId"]
        call_api(@reportId)
        e = extract_data()
        @elements.push(e)
    end
  end

  def update
    super()
  end

  def validate_query
    super(query_param)
  end
  
  private

  def query_param
    params[:query]
end



end