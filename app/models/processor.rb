# == Schema Information
# Schema version: 20090605012055
#
# Table name: frs_processor
#
#  processor_id :integer         not null, primary key
#  name         :text
#

class Processor < ActiveRecord::Base
  set_table_name 'frs_processor'
  set_primary_key 'processor_id'
end
