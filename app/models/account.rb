class Account < ApplicationRecord
  include Rodauth::Rails.model
  enum :type,
    candidate: 0,
    company_admin: 1,
    system_admin: 2
end
