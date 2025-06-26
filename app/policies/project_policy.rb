class ProjectPolicy < ApplicationPolicy
  def index?
    user.editor? || user.receiver_editor? || user.admin? || user.super_admin?;
  end

  def new?;       user.editor? || user.receiver_editor? || user.admin? || user.super_admin?; end
  def create?;     user.editor? || user.receiver_editor? || user.admin? || user.super_admin?; end
  def update?;     user.editor? || user.receiver_editor? || user.admin? || user.super_admin?; end
  def destroy?;    user.editor? || user.receiver_editor? || user.admin? || user.super_admin?; end
  def import_form?; create?; end
  def import_csv?;  create?; end
  def daily_report?; index?; end
  def show?;       index?; end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.editor? || user.receiver_editor? || user.admin? || user.super_admin?
        scope.all
      else
        scope.none
      end
    end
  end
end
