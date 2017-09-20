class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :create, OrderItem
    can :update, :order_items

    if user.admin?
      can :access, :rails_admin
      can :manage, :all
      cannot :create, OrderItem
      cannot :update, :order_items
      cannot :write, :review
    elsif user.persisted?
      can :read, Order, user_id: user.id
      can :write, :review
    end
  end
end
