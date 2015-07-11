require 'elasticsearch/model'

class Blog < ActiveRecord::Base
	
	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks

	validates :title, presence: true, uniqueness: true
	
	has_many :posts

	belongs_to :user
end
 
# Index all article records from the DB to Elasticsearch
Blog.import