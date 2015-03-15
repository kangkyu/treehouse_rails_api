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
  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render json: {
        status: 200,
        message: "Updated successfully",
        post: post
      }.to_json
    else
      render json: {
        status: 500,
        message: "The post could not be updated",
        post: post
      }.to_json
    end
  end
  def destroy
    post = Post.find(params[:id])
    post.destroy
    render json: {
      status: 200,
      message: "Deleted successfully"
    }
  end
  private
  def post_params
    params.require('post').permit('title')
  end
end