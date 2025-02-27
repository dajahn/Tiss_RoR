class ThesisController < SearchController
    def index
        search_type = {
            "model" => "Thesis",
            "search_term" => "Thesis name"
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
        return "https://tiss.tuwien.ac.at/api/search/thesis/v1.0/quickSearch?searchterm=" + query
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

    def call_api(thesis_id)
        @doc = super("https://tiss.tuwien.ac.at/api/thesis/#{thesis_id}")
    end

    def extract_data  
        @result = {
          "title" => @doc.at_xpath("//title/de").content,
          "subtitle" => "#{@doc.at("//thesisType").content} at #{@doc.at_xpath("//instituteName/de").content}",
          "subsubtitle" => "Keywords: #{@doc.at("//keywords/de").content}",
          "text" => "Advised by #{@doc.at_xpath("//advisor/prefixTitle").content} #{@doc.at_xpath("//advisor/givenName").content} #{@doc.at_xpath("//advisor/familyName").content}",
          "text_2" => nil,
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
        super("thesis")
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