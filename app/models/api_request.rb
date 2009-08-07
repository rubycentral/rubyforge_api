# == Schema Information
# Schema version: 20090605012055
#
# Table name: api_requests
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  ip_address    :string(255)
#  path          :string(255)
#  method        :string(255)
#  response_code :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class ApiRequest < ActiveRecord::Base
  belongs_to :user
end
