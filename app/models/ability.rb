class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :update, :destroy, to: :edt

    if user.admin?
      can :manage, :all
    elsif user.user?
      can :edt, Trip, user_id: user.id
      can :read, Trip
      can :create, Trip
      can :join_trip, Trip
    end
  end
end
