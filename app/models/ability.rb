class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    # Members can create posts and comments freely
    # but only edit/delete their own
    if user.role? :member
      can :create, Post
      can :update, Post, :user_id => user.id
      can :destroy, Post, :user_id => user.id
      can :create, Comment
      can :update, Comment, :user_id => user.id
      can :destroy, Comment, :user_id => user.id
      can :create, Vote
      can :manage, Favorite, :user_id => user.id
      can :read, Topic
    end  

    # Moderators can delete any post or comment
    if user.role? :moderator
      can :destroy, Post
      can :destroy, Comment
    end

    # Admins can do anything
    if user.role? :admin
      can :manage, :all
    end

    can :read, Topic, public: true
    can :read, Post
    can :read, Comment
  end
end