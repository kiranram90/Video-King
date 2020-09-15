class ApplicationController < Sinatra::Base

configure do 
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "video_king_lv"
end


helpers do
    def logged_in?
        !!current_user
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def login(email, password)
        user = User.find_by(:email => email)
       if user && user.authenticate(password)
         session[:user_id] = user.id
        else 
         redirect 'login'
       end
    end

    def logout
        session.clear 
        #email them when they log out for further development
    end
end
end

