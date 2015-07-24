class UserMailer < ActionMailer::Base
  default from: "BlogBot@blogme.com"

  def follow_notification(blog_owner, follower, followed_blog)
  	@user = blog_owner
  	@follower = follower
  	@blog = followed_blog
  	mail(to: @user.email, subject: "You have a new follower!")
  end

end
