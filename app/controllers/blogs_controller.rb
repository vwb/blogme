class BlogsController < ApplicationController

	def new
	  @blog = Blog.new
	end


	def show
	  @blog = Blog.find(params[:id])
	end


	def create
	  @blog = Blog.create(blog_params)
	  @blog.user = current_user
	  @blog.username = current_user.username
	  if @blog.save
	  	  redirect_to blog_path(@blog.id)
	  else
	  	  redirect_to root_path
	  end
	end


	def edit
		@blog = Blog.find(params[:id])
	end

	def destroy
		@blog = Blog.find(params[:id])
		@posts = @blog.posts
		
		@posts.each do |i|
			i.destroy
		end
		
		if @blog.destroy
			redirect_to blogs_path
		else
			redirect :back
		end
	end

	def update
		@blog = Blog.find(params[:id])
		@blog.description = params[:blog][:description]
		@blog.title = params[:blog][:title]
		@blog.location = params[:blog][:location]
		if @blog.save 
			redirect_to blog_path(@blog.id)
		else
			redirect_to :back
		end
	end


	def index
	  @blogs = User.find(current_user).blogs
	  @following = current_user.following.order('created_at DESC')
	end

	def index_all
	  @blogs = Blog.all
	end

	private

	def blog_params
		params.require(:blog).permit(:title, :description)
	end

end
