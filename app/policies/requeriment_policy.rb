class RequerimentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope => class Requeriment
      scope.where(user: user)
    end
  end

  def show?
    is_owner? || user.admin
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    # user => current_user
    # record => @requeriment
    is_owner? || user.admin
  end

  def update?
    is_owner? || user.admin
  end

  def destroy?
    is_owner? || user.admin
  end

  private

  def is_owner?
    record.user == user
  end
end
