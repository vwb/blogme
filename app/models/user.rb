class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: true

  has_many :blogs
  has_many :posts, through: :blogs
  has_many :comments, through: :posts

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
