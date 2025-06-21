class UserPolicy < ApplicationPolicy
  def update?
    user.admin? || user == record
  end

  def permitted_attributes_for_update
    user.admin? ? %i[role] : %i[email]
  end
end
