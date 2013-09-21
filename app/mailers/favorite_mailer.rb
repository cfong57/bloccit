class FavoriteMailer < ActionMailer::Base
  default from: "christopher.m.fong@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    # New Headers
    headers["Message-ID"] = "<comments/#{@comment.id}@tetris-bloccit.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{@post.id}@tetris-bloccit.herokuapp.com>"
    headers["References"] = "<post/#{@post.id}@tetris-bloccit.herokuapp.com>"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
  
  #def new_post(user, topic, post)
  #  @user = user
  #  @topic = topic
  #  @post = post
  #
    # New Headers
  #  headers["Message-ID"] = "<posts/#{@post.id}@tetris-bloccit.herokuapp.com>"
  #  headers["In-Reply-To"] = "<topic/#{@topic.id}@tetris-bloccit.herokuapp.com>"
  #  headers["References"] = "<topic/#{@topic.id}@tetris-bloccit.herokuapp.com>"
#
 #   mail(to: user.email, subject: "New post in #{topic.name}")
  #end
end