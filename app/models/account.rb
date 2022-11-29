class Account < ApplicationRecord
  include Rodauth::Rails.model

  enum user_type: [
    :candidate,
    :org_admin,
    :sys_admin
  ]
end
