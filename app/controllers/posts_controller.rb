class PostsController < ApplicationController
     
     before_action :authenticate_user!
     before_action :owned_post, only: [:edit, :update, :destroy]

     def index
          @posts = Post.all
     end

     def new
          @post = current_user.posts.new
     end

     def create
          @post = current_user.posts.new(post_params)
          if(@post.save)
               redirect_to posts_path
          else
               render 'new'
          end
     end

     def edit
          @post = Post.find(params[:id])
     end

     def update
          @post = Post.find(params[:id])
          if @post.update(post_params)
               redirect_to(post_path(@post))
          else
               render 'edit'
          end
     end

     def destroy
          @post = Post.find(params[:id])
          @post.destroy
          redirect_to posts_path
     end

     def show
          @post = Post.find(params[:id])
     end

     private

          def post_params
               params.require(:post).permit(:image, :caption)
          end

          def owned_post
               @post = Post.find(params[:id])
               unless current_user == @post.user
                    redirect_to root_path
               end
          end
end
