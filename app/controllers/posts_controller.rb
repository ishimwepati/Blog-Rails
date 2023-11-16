class PostsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)

    render json: @posts, except: %i[created_at updated_at]
  end

end