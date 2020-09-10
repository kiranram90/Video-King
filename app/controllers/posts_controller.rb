class PostsController < ApplicationController


    #Read 
    #Index 
    #make a get to /posts

    #show
    #make a get request to '/recipies:id'

    # index
    get '/posts' do
        @posts = Post.all
        # "Here are the list of all your favorite video games"
        erb :'posts/index' # nesting in posts/index
    end

    # show
    get '/posts/:id' do 
        @post = Post.find(params["id"])
        erb :'posts/show' # when the user click on the game link it takes you to the game.
    end
    
    # New
    get '/posts/new' do
        #checking if they are logged in
        if !logged_in?
          redirect "/login" # Redirecting if they aren't
        else
         "A new post form" # rendering if they are
        end
    end

    # Edit
    get 'posts/:id/edit' do
        #checking if they are logged in
        if !logged_in?
            redirect "/login" # Redirecting if they aren't
        else
            if post = current_user.posts.find(params[:id]) # rendering if they are
           "An edit post form #{current_user.id} is editing #{post.id}" 
            else 
            redirect '/posts'
            end
        end     
    end
end