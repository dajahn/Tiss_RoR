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
        if @calledByReport == 1
            thesis_id = @reportId
            @calledByReport = nil
            @reportId = nil
        else
            thesis_id = params.require(:id)
        end
        @doc = super("https://tiss.tuwien.ac.at/api/thesis/#{thesis_id}")
        @result = {
          "title" => @doc.at_xpath("//title/de").content,
          "subtitle" => "#{@doc.at("//thesisType").content} at #{@doc.at_xpath("//instituteName/de").content}",
          "subsubtitle" => "Keywords: #{@doc.at("//keywords/de").content}",
          "text" => "Advised by #{@doc.at_xpath("//advisor/prefixTitle").content} #{@doc.at_xpath("//advisor/givenName").content} #{@doc.at_xpath("//advisor/familyName").content}",
          "text_2" => nil
        }
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
        super("thesis")
        @elements = []
        for i in 0..@favorites.count-1
            @calledByReport = 1
            @reportId = @favorites[i]["objectId"]
            e = details
            @elements.push(e)
        end

        puts "\n"
        puts "\n"
        puts "\n"
        puts "\n"
        puts "\n"
        puts "\n"
        puts "\n"
        puts "\n"
        puts "\n"
        puts "\n"
        puts "\n"
        puts "\n"
        puts "\n"
        puts "\n"
        puts "\n"
        puts @elements
    end

    private

    def query_param
        params.require(:query)
    end 
end