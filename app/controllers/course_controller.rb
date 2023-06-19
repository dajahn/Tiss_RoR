class CourseController < SearchController
  def index
    search_type = {
      "model" => "Course",
      "search_term" => "Course name"
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
    set_course_props()
    logger.info @result
    @result
    render :list
  end

  def get_search_results(url)
    super(url)
    set_course_props()
  end

  def get_search_url(query)
    return "https://tiss.tuwien.ac.at/api/search/course/v1.0/quickSearch?searchterm=" + query
  end

  def set_course_props
    @result.each do |res|
      res["course_num"] = get_course_number_from_url(res["detail_url"])
      res["semester"] = get_course_semester_from_url(res["detail_url"])
    end
  end

  def details
    @id = params.require(:id)
    @semester = params.require(:semester)
    call_api(@id, @semester)
    extract_data()
  end

  def call_api(course_id, course_semester)
    @doc = super("https://tiss.tuwien.ac.at/api/course/#{course_id}-#{course_semester}")
  end

  def extract_data
    @result = {
      "title" => @doc.at_xpath("//title/de").content+" "+ @doc.at_xpath("//course/semesterCode").content,
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
    @isFav = super()
  end

  def report
    super("course")
    @elements = []
    for i in 0..@favorites.count-1
        @reportId = @favorites[i]["objectId"]
        @reportSem = get_semester_from_course_name(@favorites[i]["title"][-5..-1])
        call_api(@reportId, @reportSem)
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

  def get_course_number_from_url(url)
    matches = url.match /courseNr=(\d*)/
    matches[1]
  end

  def get_course_semester_from_url(url)
    matches = url.match /semester=(\d*[W|S])/
    matches[1]
  end

  def query_param
    params[:query]
  end


end