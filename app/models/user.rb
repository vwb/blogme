class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: true

  has_many :blogs, dependent: :destroy
  has_many :posts, through: :blogs
  has_many :comments, through: :posts

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed


  # Follows a blog.
  def follow(chosen_blog)
    active_relationships.create(followed_id: chosen_blog.id)
  end

  # Unfollows a blog.
  def unfollow(chosen_blog)
    active_relationships.find_by(followed_id: chosen_blog.id).destroy
  end

  # Returns true if the current user is following the blog.
  def following?(chosen_blog)
    following.include?(chosen_blog)
  end

  def feed
    Post.where("blog_id IN (?)", following_ids).order('created_at DESC')
  end

  has_attached_file :avatar, 
   :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:filename", 
   :url => "/system/:class/:attachment/:id_partition/:style/:filename",
   :styles => { :medium => "300x300>", :thumb => "100x100>"},
   :default_url => "/:attachment/:style/missing.png"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end

end
