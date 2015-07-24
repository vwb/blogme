require 'elasticsearch/model'

class Blog < ActiveRecord::Base
	
	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks

	validates :title, presence: true
	
	has_many :posts

	belongs_to :user

	has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy

  	has_many :followers, through: :passive_relationships, source: :follower

end
 
# Index all article records from the DB to Elasticsearch
Blog.import