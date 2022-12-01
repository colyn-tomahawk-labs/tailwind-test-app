class ApplicationController < ActionController::Base
  include RapidfireEvals

  private

  # override can_administer? used by rapidfire gem
  def can_administer?
    current_account.sys_admin?
  end

  def current_user
    current_account
  end
end
