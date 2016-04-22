class UsersController < ApplicationController
  def show
    current_user
  end

  def downgrade
    current_user.standard!
    current_user.wikis.update_all(private: false)
    flash[:notice] = "Membership has been downgraded top Standard"
    redirect_to :back
  end
end
