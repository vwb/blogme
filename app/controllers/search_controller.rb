class SearchController < ApplicationController
	def search
  		if params[:q].nil?
   			@posts = []
   			@blogs = []
  		else
  			@params = params[:q][0]
    		@posts = Post.search params[:q]
    		@blogs = Blog.search params[:q]
    		params.delete :q
 		end
	end
end
