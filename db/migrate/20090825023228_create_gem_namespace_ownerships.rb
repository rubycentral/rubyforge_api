class CreateGemNamespaceOwnerships < ActiveRecord::Migration
  def self.up
    create_table :gem_namespace_ownerships do |t|
      t.integer :group_id, :null => false
      t.string :namespace, :null => false
      t.timestamps
    end
    add_index :gem_namespace_ownerships, :group_id
    add_index :gem_namespace_ownerships, [:group_id, :namespace]
  end

  def self.down
    drop_table :gem_namespace_ownerships
  end
end
