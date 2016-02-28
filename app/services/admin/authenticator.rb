class Admin::Authenticator
  def initialize(admin_user)
    @admin = admin_user
  end

  def authenticate
    @amdin && @admin.email
  end

  def account_lock?
    @amdin.suspended?
  end
end
