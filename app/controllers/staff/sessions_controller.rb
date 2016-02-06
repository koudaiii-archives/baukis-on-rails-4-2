class Staff::SessionsController < Staff::Base
  def new
    if current_steaff_member
      redirect_to :staff_root
    else
      @form = Staeff::LoginForm.new
      render action: 'new'
    end
  end
end
