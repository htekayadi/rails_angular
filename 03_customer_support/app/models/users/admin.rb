class Admin < User
  after_initialize :init

  before_destroy :check_if_not_last

  private

  def init
    self.type ||= "admin"
  end

  # Prevents the last admin from being deleted
  def check_if_not_last
    if Admin.count === 1
      errors.add :admin, "Cannot delete last admin"
      throw :abort
    end
  end
end