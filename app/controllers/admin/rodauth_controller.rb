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
    # TODO
  end

  private

  def account_params
    params.require(:account).permit(:email, :password, :user_type)
  end
end