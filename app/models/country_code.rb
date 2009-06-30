class CountryCode < ActiveRecord::Base
  set_table_name "country_code"
  
  def self.add(name, code)
    ActiveRecord::Base.connection.execute "insert into country_code values ('#{name}', '#{code}')"
  end
  
end