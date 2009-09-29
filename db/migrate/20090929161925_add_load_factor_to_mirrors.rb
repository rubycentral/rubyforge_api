class AddLoadFactorToMirrors < ActiveRecord::Migration

  def self.up
    add_column :mirrors, :load_factor, :integer, :default => 1, :null => false
  end

  def self.down
    remove_column :mirrors, :load_factor
  end
end
