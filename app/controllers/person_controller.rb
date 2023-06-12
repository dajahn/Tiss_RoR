class PersonController < SearchController

    def index
        search_type = {
            "model" => "Person",
            "search_term" => "Name"
        }
        super(search_type)
    end

    def search
        query = query_param
        url = get_search_url(query)
        super(url)
    end

    def get_search_url(query)
        return "https://tiss.tuwien.ac.at/api/person/v21/psuche?q=" + query;
    end

    def get_search_results(url)
        @results = super(url)
    end

    def details
        @id = params.require(:id)
        call_api(@id)
        @links_query = "#{@person["first_name"]}+#{@person["last_name"]}"
        @isFav = isFav()
        return @person
    end

    def call_api(id)
        uri = URI("https://tiss.tuwien.ac.at/api/person/v22/id/#{id}")
        response = Net::HTTP.get(uri)
        @person = JSON.parse(response)
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
        super("person")
        @people = []
        for i in 0..@favorites.count-1
            @reportId = @favorites[i]["objectId"]
            p = call_api(@reportId)
            @people.push(p)
        end
    end

    
    def fullReport
        @data = []
        person = call_api(params[:id])
        @data.push(person)

        [ProjectController, ThesisController].each do |controller|
            currController = controller.new
            url = currController.get_search_url(params[:query])
            results = currController.get_search_results(url)
            @data.push(results)
        end

        currController = CourseController.new
        
    end

    private

    def query_param
        params.require(:query)
    end
end