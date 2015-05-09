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
    captcha_message = "The data you entered for the CAPTCHA wasn't correct. Please try again."
    @post = Post.new(post_params)
    if !verify_recaptcha(model: @post, message: captcha_message) || !@post.save
      render 'new'
    else
      redirect_to @post
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
