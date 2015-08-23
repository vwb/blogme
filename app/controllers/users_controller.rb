class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@activity = @user.posts.order('created_at DESC').limit(5)
		@blogs = @user.blogs
		@following = @user.following.order('created_at DESC')
	end

	def discover
		@discover_posts = Post.paginate(page: params[:page], per_page: 6).order('created_at DESC')
		respond_to do |format|
			format.html
			format.js
		end
	end

	def home
		@user = current_user
		@following = @user.following.order('created_at DESC')		
		@feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
	end





end
