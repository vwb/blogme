class CommentsController < ApplicationController
	#before_filter :authenticate_user!

	def new
		@comment = Comment.new
	end

	def show
		@comment = Comment.find(params[:id])
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		if user_signed_in?
			@comment.user_id = current_user.id
		end
		if @comment.save
			redirect_to post_path(@post)
		else
			redirect_to :back
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		comment_holder = @comment.post
		if @comment.destroy
			redirect_to post_path(comment_holder.id)
		else
			redirect_to :back
		end
	end



	private

	def comment_params
		params.require(:comment).permit(:content, :user_id, :name)
	end

end
