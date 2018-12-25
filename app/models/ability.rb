# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)

    if user.new_record?
      can :create, User, status: %(pending)
      can :read, Story, status: %(published)
      can :read, Scene
      can :read, Question
    end

    return unless user.present?

    can :manage, Story, user_id: user.id, status: %w[new pending published rejected]
    can :manage, Scene
    can :manage, SceneAction
    can :manage, Question
    can :manage, Choice

    can :manage, :all if user.admin?

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
