class PostsController < ApplicationController


    get '/posts' do
        "Here are the list of all your favorite video games"
    end

    get '/posts/new' do
        #checking if they are logged in
        if !logged_in?
          redirect "/login" # Redirecting if they aren't
        else
         "A new post form" # rendering if they are
        end
    end


    get 'posts/:id/edit' do
        #checking if they are logged in
        if !logged_in?
            redirect "/login" # Redirecting if they aren't
          else
           "An edit post form" # rendering if they are
          end
    end     

end