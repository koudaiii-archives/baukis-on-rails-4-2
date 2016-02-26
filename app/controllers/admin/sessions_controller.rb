class Admin::SessionsController < ApplicationController
  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Admin::LoginForm.new(params[:admin_login_form])
    if @form.email.present?
      administrator = Administrator.find_by(email_for_index: @form.email.downcase)
    end
    authenticator = Admin::Authenticator.new(administrator)
    if !administrator.nil? && authenticator.authenticate(@form.password)
      if authenticator.account_lock?
        flash.now.alert = 'アカウントが停止されています'
        render action: 'new'
      else
        session[:staff_member_id] = administrator.id
        flash.notice = 'ログインしました。'
        redirect_to :staff_root
      end
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render action: 'new'
    end
  end
end
