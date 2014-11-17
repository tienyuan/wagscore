class LocationPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    true #user.present? && user.admin?
  end

  def destroy?
    user.present? && user.admin?
  end
end