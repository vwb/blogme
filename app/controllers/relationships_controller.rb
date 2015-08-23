 class RelationshipsController < ApplicationController
	before_filter :authenticate_user!

	def create
		@blog = Blog.find(params[:followed_id])
		current_user.follow(@blog)
		UserMailer.follow_notification(@blog.user, current_user, @blog).deliver
		respond_to do |format|
      		format.html { redirect_to @blog }
      		format.js
      	end
	end

	def destroy
		@blog = Relationship.find(params[:id]).followed
		current_user.unfollow(@blog)
		respond_to do |format|
      		format.html { redirect_to @blog }
      		format.js
      	end
	end


end
