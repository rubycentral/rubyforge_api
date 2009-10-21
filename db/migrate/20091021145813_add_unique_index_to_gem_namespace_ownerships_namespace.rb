class AddUniqueIndexToGemNamespaceOwnershipsNamespace < ActiveRecord::Migration

  def self.up
    add_index :gem_namespace_ownerships, :namespace, :unique => true
  end

  def self.down
    remove_index :gem_namespace_ownerships, :namespace
  end
end
