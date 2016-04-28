class WikiPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.admin? || user.premium?
        scope.all
      else
        scope.where(private: nil)
      end
    end
  end

  def show?
    if user.admin? || user.premium?
      scope.all
    else
      scope.where(private: nil)
    end
  end

  def update?
    user.admin? or not post.published?
  end
end
