class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      can :read, Order, user_id: user.id
      can :create, :review
    end
  end
end
