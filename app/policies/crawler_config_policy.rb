class CrawlerConfigPolicy < ApplicationPolicy
 def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolves
      user.admin? ? scope.all : scope.none
    end
  end
end
