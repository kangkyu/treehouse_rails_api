class Api::PostsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    render :json => Post.all
  end
  def show
    render :json => Post.find(params[:id])
  end
  def create
    post = Post.new(post_params)
    if post.save
      render json: {
        status: 200,
        message: "Saved successfully",
        post: post
      }.to_json
    else
      render json: {
        status: 500,
        errors: post.errors
      }.to_json
    end
  end
  private
  def post_params
    params.require('post').permit('title')
  end
end