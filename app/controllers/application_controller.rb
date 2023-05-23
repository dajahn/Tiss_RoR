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

    def addFavorite
        objectId = params[:id]
        title = params[:title]
        fav = Favorite.new(objectId: objectId, entryType: Current.search_page_name, user_id: Current.user.id, title: title)

        if fav.valid?
            fav.save
            flash[:notice] = "The entry has been favorited successfully."
        else
            flash[:alert] = fav.errors.full_messages
        end

        redirect_to request.original_url
    end

    def removeFavorite
        objectId = params[:id]

        fav = Favorite.find_by(objectId: objectId, entryType: Current.search_page_name, user_id: Current.user.id)

        if !fav.nil?
            fav.destroy
            flash[:notice] = "The entry has been removed successfully."
        else
            flash[:alert] = "This entry was not favorited and thus cannot be removed"
        end

        redirect_to request.original_url
    end

    def isFav
        objectId = params[:id]

        !Favorite.find_by(objectId: objectId, entryType: Current.search_page_name, user_id: Current.user.id).nil?
    end
end
