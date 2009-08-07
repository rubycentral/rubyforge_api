# == Schema Information
# Schema version: 20090605012055
#
# Table name: licenses
#
#  license_id   :integer         not null, primary key
#  license_name :text
#

class License < ActiveRecord::Base
  set_primary_key 'license_id'
end
