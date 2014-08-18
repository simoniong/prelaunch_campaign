class IpAddress < ActiveRecord::Base
  validates :address, uniqueness: true
end
