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
      render status: 200, json: {
        message: "Saved successfully",
        post: post
      }.to_json
    else
      render status: 422, json: {
        errors: post.errors
      }.to_json
    end
  end
  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render status: 200, json: {
        message: "Updated successfully",
        post: post
      }.to_json
    else
      render status: 422, json: {
        message: "The post could not be updated",
        post: post
      }.to_json
    end
  end
  def destroy
    post = Post.find(params[:id])
    post.destroy
    render status: 200, json: {
      message: "Deleted successfully"
    }
  end
  private
  def post_params
    params.require('post').permit('title')
  end
end