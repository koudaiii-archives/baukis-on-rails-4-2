class Admin::Authenticator
  def initialize(admin_user)
    @admin = admin_user
  end
  def authenticate
    @amdin &&
      @admin.start_date <= Date.today &&
      (@admin.end_date.nil? || @admin.end_date > Date.today) &&
      BCrypt::Password.new(@admin.hashed_password) == raw_password
  end
end
