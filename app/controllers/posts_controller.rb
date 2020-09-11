class PostsController < ApplicationController


    #Read 
    #Index 
    #make a get to /posts

    #show
    #make a get request to '/recipies:id'

    # index
     get '/' do 
        redirect "/posts"
     end

    get '/posts' do
        if !logged_in?
            redirect "/login" # Redirecting if they aren't
          else
        @posts = Post.all
        # "Here are the list of all your favorite video games"
        erb :'posts/index' # nesting in posts/index
          end
    end

     # New
     get '/posts/new' do
        #checking if they are logged in
        if !logged_in?
          redirect "/login" # Redirecting if they aren't
        else
         erb :'posts/new' # rendering if they are
        end
    end

    # show
    get '/posts/:id' do 
        @post = Post.find(params["id"])
        erb :'posts/show' # when the user click on the game link it takes you to the game.
    end
    
    # create
    post '/posts' do
        @post = Post.new 
        @post.title = params[:title]
        @post.content = params[:content]
        @post.user_id = current_user.id
        if @post.save 
            redirect '/posts'
        else 
            @error = "Post contains errors"
            erb :"posts/new"
        end
    end

    #update
    patch '/posts/:id' do 
        @post = Post.find(params[:id])
        if !params["title"].empty? && !params["content"].empty?
            @post.title = params[:title]
            @post.content = params[:content]
            @post.save
            redirect "/posts/#{params[:id]}"
        else
            @error = "Data invalid. Please try again"
            erb :'posts/edit'
        end
    end


    # Edit
    get '/posts/:id/edit' do
        #checking if they are logged in
        if !logged_in?
            redirect "/login" # Redirecting if they aren't
        else
            if @post = current_user.posts.find(params[:id]) # rendering if they are the owner
                # "An edit post form #{current_user.id} is editing #{post.id}" 
                erb :'posts/edit'
            else 
                redirect '/posts'
            end
        end     
    end

    # Delete
    delete '/posts/:id' do
        if !logged_in?
            redirect "/login" # Redirecting if they aren't
        else
            if @post = current_user.posts.find(params[:id]) # delete if they are the owner
                @post.delete
                redirect '/posts'
            else 
                redirect '/posts'
            end
        end
    end
end