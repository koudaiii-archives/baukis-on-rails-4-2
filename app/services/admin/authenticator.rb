class Admin::Authenticator
  def initialize(admin_user)
    @admin = admin_user
  end

  def authenticate
    @admin && @admin.email
  end

  def account_lock?
    @admin.suspended?
  end
end
