class Account < ApplicationRecord
  include Rodauth::Rails.model

  enum user_type: [
    :candidate,
    :company_admin,
    :system_admin
  ]
end
