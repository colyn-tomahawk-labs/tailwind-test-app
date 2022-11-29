class Admin::RodauthController < ApplicationController

  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end

  def create
    if account = Account.create!(account_params)
      # The following should work but is currectly throwing a crytpic exception
      # RodauthApp.rodauth(:admin).verify_account(account_login: account.email)

      account.update!(status: 2) # verify user with brute force
      redirect_to admin_users_path
    else
      redirect_to admin_users_new_path
    end
  end

  def edit
    @account = Account.find(params[:format])
  end

  def update
    account = Account.find_by(email: account_params[:email])
    account.update!(account_params.to_h)
    
    if account_params[:user_type] != 'system_admin'
      redirect_to root_path
    else
      redirect_to admin_users_path
    end
  end

  private

  def account_params
    params.require(:account).permit(:email, :password, :user_type)
  end
end