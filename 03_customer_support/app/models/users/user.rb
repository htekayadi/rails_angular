class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable

  validates :email, :presence => true, :uniqueness => true

  include DeviseTokenAuth::Concerns::User

  before_validation :downcase_email
  before_save :set_default_type

  before_save -> { skip_confirmation! }

  def is_a_customer?
    return self.type == "Customer"
  end

  def is_an_agent?
    return self.type == "Agent"
  end

  def is_an_admin?
    return self.type == "Admin"
  end

  private

  def set_default_type
    self.type ||= "Customer"
  end

  def downcase_email
    self.email = emai.downcase if email.present?
  end
end
