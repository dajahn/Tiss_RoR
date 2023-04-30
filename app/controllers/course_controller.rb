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
      res["course_num"] = get_course_number_from_url(res["detail_url"])
      res["semester"] = get_course_semester_from_url(res["detail_url"])
    end
    logger.info @result
    @result
    render :list
  end

  def details
    course_id = params.require(:id)
    course_semester = params.require(:semester)
    @doc = super("https://tiss.tuwien.ac.at/api/course/#{course_id}-#{course_semester}")
    @result = {
      "title" => @doc.at_xpath("//title/de").content,
      "subtitle" => "Course: " +@doc.at_xpath("//course/courseNumber").content + ", in #{@doc.at_xpath("//course/semesterCode").content}, as #{@doc.at_xpath("//course/courseType").content}",
      "subsubtitle" => @doc.at_xpath("//objective/de").content,
      "text" => "#{@doc.at_xpath("//teachingContent/de").content}",
      "text_2" => "#{ @doc.at_xpath("//additionalInformation/de").content}",
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
      super()
  end

  private

  def get_course_number_from_url(url)
    matches = url.match /courseNr=(\d*)/
    matches[1]
  end

  def get_course_semester_from_url(url)
    matches = url.match /semester=(\d*[W|S])/
    matches[1]
  end

  def query_param
    params.require(:query)
  end
end