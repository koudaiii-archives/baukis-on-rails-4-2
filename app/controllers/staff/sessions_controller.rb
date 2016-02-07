class Staff::SessionsController < Staff::Base
  def new
    if current_steaff_member
      redirect_to :staff_root
    else
      @form = Staeff::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      session[:staff_member_id] = staff_member
      redirect_to :staff_root
    else
      render action: 'new'
    end
  end
end
