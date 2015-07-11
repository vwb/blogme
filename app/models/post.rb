require 'elasticsearch/model'

class Post < ActiveRecord::Base


	validates :location, presence: true
	belongs_to :user
	belongs_to :blog
	has_many :comments


	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks

	def next
		blog.posts.where("id > ?", self.id).order("id ASC").first
	end

	def previous
		blog.posts.where("id < ?", self.id).order("id DESC").first
	end

end

# Delete the previous articles index in Elasticsearch
Post.__elasticsearch__.client.indices.delete index: Post.index_name rescue nil
 
# Create the new index with the new mapping
Post.__elasticsearch__.client.indices.create \
  index: Post.index_name,
  body: { settings: Post.settings.to_hash, mappings: Post.mappings.to_hash }
 
# Index all article records from the DB to Elasticsearch
Post.import