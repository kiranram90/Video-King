class ApplicationController < Sinatra::Base

configure do 
    set :public_folder, 'public'
    set :views, 'app/views'
    #enable :sessions
    #set :session_secret, "video_king_lv"
end


helpers do
    def logged_in?
        !!session[:email]
    end

    def login(email)
       if user = User.find_by(:email => email) 
         session[:email] =user.email
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

