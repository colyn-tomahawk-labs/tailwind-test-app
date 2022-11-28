class RodauthAdmin < Rodauth::Rails::Auth
  configure do
    # ... enable features ...
    prefix "/admin"
    session_key_prefix "admin_"
    #remember_cookie_key "_admin_remember" # if using remember feature

    enable :internal_request
    enable :verify_account

    # search views in `app/views/admin/rodauth` directory
    rails_controller { Admin::RodauthController }
  end
end