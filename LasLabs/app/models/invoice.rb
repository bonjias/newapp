class Invoice < ActiveRecord::Base
  has_one :company
end
