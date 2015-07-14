class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
	end

	def discover
		@discover_posts = Post.paginate(page: params[:page], per_page: 8).order('created_at DESC')
		respond_to do |format|
			format.html
			format.js
		end
	end

end
