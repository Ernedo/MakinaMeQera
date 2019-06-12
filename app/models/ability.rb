# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new
      if user.admin?
        can :manage, :all


      else
        can :manage, Reservation
        can :manage, Client
        can :read, Car
        cannot :manage, User
        can :manage, Photo, user_id: user.id
        can :show, Photo


      end

  end
end
