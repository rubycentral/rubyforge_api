class FrsDlstatsFiletotalAgg < ActiveRecord::Base
  
    set_table_name "frs_dlstats_filetotal_agg"
    belongs_to :frs_file, :foreign_key => :file_id
    
end