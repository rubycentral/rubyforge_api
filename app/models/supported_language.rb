# == Schema Information
# Schema version: 20090605012055
#
# Table name: supported_languages
#
#  language_id   :integer         not null, primary key
#  name          :text
#  filename      :text
#  classname     :text
#  language_code :string(5)
#

class SupportedLanguage < ActiveRecord::Base
  set_primary_key 'language_id'
end
