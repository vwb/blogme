 class RelationshipsController < ApplicationController
	before_filter :authenticate_user!

	def create
		@blog = Blog.find(params[:followed_id])
		current_user.follow(@blog)
		UserMailer.follow_notification(@blog.user, current_user, @blog).deliver
		redirect_to @blog
	end

	def destroy
		blog = Relationship.find(params[:id]).followed
		current_user.unfollow(blog)
		redirect_to blog
	end


end
