class UsersController < ApplicationController
  def index
  end
  def show
    @user = current_user
  end
  def new
  end

  def edit
  end

  def remove_overdue
    if params[:overdue_paid] && current_user.overdues.present?
      current_user.overdues.first.destroy
    end
    redirect_to account_path
  end
  
end
