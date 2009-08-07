# == Schema Information
# Schema version: 20090605012055
#
# Table name: country_code
#
#  country_name :string(80)
#  ccode        :string(2)       not null
#

class CountryCode < ActiveRecord::Base
  set_table_name "country_code"
  
  def self.add(name, code)
    ActiveRecord::Base.connection.execute "insert into country_code values ('#{name}', '#{code}')"
  end
  
end
