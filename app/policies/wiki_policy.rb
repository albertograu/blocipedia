class WikiPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def index?
        if @user.admin? || @user.premium?
          scope.all
        else
          scope.where(private: false)
        end
      end
    end

    def show?

    end

    def resolve
      if user.admin? || user.premium?
        scope.all
      else
        scope.where(private: nil)
      end
    end
  end

  def create?
  end

  def destroy?
  end

  def update?
    user.admin? || user.premium?
  end
end
