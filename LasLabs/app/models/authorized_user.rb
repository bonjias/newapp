class AuthorizedUser < ActiveRecord::Base
  has_one :company
  
  has_one :user, foreign_key: 'email', primary_key: 'email'

end
