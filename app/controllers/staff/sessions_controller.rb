class Staff::SessionsController < Staff::Base
  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)
    end
    authenticator = Staff::Authenticator.new(staff_member)
    if !staff_member.nil? && authenticator.authenticate(@form.password)
      if authenticator.account_lock?
        flash.now.alert = 'アカウントが停止されています'
        render action: 'new'
      else
        session[:staff_member_id] = staff_member.id
        flash.notice = 'ログインしました。'
        redirect_to :staff_root
      end
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render action: 'new'
    end
  end

  def destroy
    session.delete(:staff_member_id)
    flash.notice = 'ログアウトしました。'
    redirect_to :staff_root
  end
end
