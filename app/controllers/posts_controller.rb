class PostsController < ApplicationController
	layout :resolve_layout

	def new
		@post = Post.new
		@post.blog_id = params[:blogID]
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments.all
		@comment = @post.comments.build
		@previous_post = @post.previous
		@next_post = @post.next
		@blog = Blog.find(@post.blog_id)
	end

	def create
		@post = Post.create(post_params)
		@post.user = current_user
		if @post.save
			redirect_to blog_path(@post.blog)
		else
			redirect_to root_path
		end
	end

	def destroy
		@post = Post.find(params[:id])
		blog = @post.blog_id
		if @post.destroy
			respond_to do |format|
  				format.js {render inline: "location.reload();" }
			end
		end
	end

	def update
		@post = Post.find(params[:id])
		@post.title = params[:post][:title]
		@post.content = params[:post][:content]
		@post.location = params[:post][:location]
		if @post.save 
			redirect_to blog_path(@post.blog_id)
		else
			redirect_to :back
		end
	end

	def edit
		@post = Post.find(params[:id])
	end


	private

	def post_params
		params.require(:post).permit(:title, :content, :location, :blog_id)
	end

	def resolve_layout
		case action_name
		when "show"
			"home_layout"
		else
			"application"
		end
	end


end
