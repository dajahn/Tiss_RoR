class CourseController < SearchController
    def index
        search_type = {
            "model" => "Course",
            "search_term" => "Course name"
        }
        super(search_type)
    end

    def search
        @query = query_param
        super("https://tiss.tuwien.ac.at/api/search/course/v1.0/quickSearch?searchterm=" + @query)
        @result.each do |res|
            res["courseNum"]  = get_course_number_from_url(res["detail_url"])
            res["semester"]  = get_course_semester_from_url(res["detail_url"])
        end
        logger.info @result[1]
    end

    def details
        logger.info "------"
        logger.info params

        course_id = params.require(:id)
        course_semester = params.require(:semester)
        @doc = super("https://tiss.tuwien.ac.at/api/course/#{course_id}-#{course_semester}")
        ##TODO
        logger.info @doc.at("shortDescription").content
        logger.info @doc.at_xpath("//title/de").content
        logger.info @doc.at_xpath("//abstract/de").content
        logger.info @doc.at_xpath("//projectForm").content
        logger.info @doc.at_xpath("//keywords/keyword/de").content
    end



    private

    def  get_course_number_from_url(url)
        matches = url.match /courseNr=(\d*)/
        matches[1]
    end

    def get_course_semester_from_url(url)
        matches = url.match /semester=(\d*)[W|S]/
        matches[1]
    end

    def query_param
        params.require(:query)
    end
end