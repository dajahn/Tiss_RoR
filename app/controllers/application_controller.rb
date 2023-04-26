class ApplicationController < ActionController::Base
    before_action :set_current_user, :set_current_sub_site

    def set_current_user
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id])
        end
    end

    def set_current_sub_site
        if session[:user_id]
            path = request.path
            if path.include? "course"
                Current.search_page_name = "course"
            elsif path.include? "person"
                Current.search_page_name = "person"
            elsif path.include? "thesis"
                Current.search_page_name = "thesis"
            elsif path.include? "project"
                Current.search_page_name = "project"
            else
                Current.search_page_name = "other"
            end
        end
    end
end
