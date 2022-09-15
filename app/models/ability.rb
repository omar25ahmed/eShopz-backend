class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, Product
    can :read, Category
    return unless user.present?

    can :read, Order, user_id: user.id
    can :read, OrderDetail, user_id: user.id
    can :manage, User, id: user.id
    can :manage, ShippingAddress, user_id: user.id
    can :manage, ProductCart, user_id: user.id
    return unless user.admin?

    can :manage, :all
  end
end
