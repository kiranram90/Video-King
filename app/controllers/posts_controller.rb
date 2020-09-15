class PostsController < ApplicationController


    # index
     get '/' do 
        redirect "/login"
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

    # showcase
    get '/posts/user/:user_id' do 
        @posts = Post.where(user_id: params["user_id"])
        erb :'posts/showcase' # when the user click on the email it takes you to a page with all user posts. 
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
        if !params["title"].empty? && !params["content"].empty? && current_user.id == @post.user_id
            @post.title = params[:title]
            @post.content = params[:content]
            @post.save
            redirect "/posts/#{params[:id]}"
        else
            @error = "Data invalid. Please try again"
            redirect "/posts/#{params[:id]}/edit"
        end
    end


    # Edit
    get '/posts/:id/edit' do
        #checking if they are logged in
        if !logged_in?
            redirect "/login" # Redirecting if they aren't
        else
            if @post = Post.find(params[:id])
                if @post.user.id == current_user.id
                    erb :'posts/edit'
                else
                    erb :'posts/error'
                end
                     # rendering if they are the owner
                # "An edit post form #{current_user.id} is editing #{post.id}" 
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
            if @post = Post.find(params[:id])
                if @post.user.id == current_user.id
                    @post.destroy
                    redirect '/posts'
                else
                    erb :'posts/error'
                end
            end
        end
    end

    #logout
    get 'logout' do
        logout
    end
end