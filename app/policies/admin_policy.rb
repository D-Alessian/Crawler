class AdminPolicy < Struct.new(:user, :admin)
  def manage_users?
    user.super_admin? || user.admin?
  end
end
