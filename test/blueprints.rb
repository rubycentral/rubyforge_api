require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.user_name  { Faker::Internet.user_name }
Sham.email { Faker::Internet.email }

UserType.blueprint do
  type_name 'User'
end

License.blueprint do
  license_name Faker::Lorem.paragraph
end

SupportedLanguage.blueprint do
  name "English"
  filename "English.class"
  classname "English"
  language_code 'en'
end

Group.blueprint do
  unix_group_name Faker::Internet.user_name
  license { License.first }
end

Role.blueprint do
  role_name "Admin"
  group { Group.first }
end

User.blueprint do
  user_name
  email
  user_pw Digest::MD5.hexdigest("secret")
  ccode { CountryCode.first } 
  supported_language { SupportedLanguage.first } 
  user_type { UserType.first } 
end

