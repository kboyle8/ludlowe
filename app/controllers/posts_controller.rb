class PostsController < ApplicationController
    http_basic_authenticate_with name: "kyle", password: "rubyRails4815162342", only: :destroy

  def new
    @post = Post.new
  end
  
  def show
      @post = Post.find(params[:id])
  end
  
  def index
    @posts = Post.all.order("created_at DESC")
  end
  
  def create
      #@post = Post.new(post_params)
      
      #if @post.save
      #redirect_to @post
      # else
      render 'new'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end
  
  private
    def post_params
      params.require(:post).permit(:name, :text)
    end
end
