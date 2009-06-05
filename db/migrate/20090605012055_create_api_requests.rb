class CreateApiRequests < ActiveRecord::Migration
  def self.up
    create_table :api_requests do |t|
      t.integer :user_id
      t.string :ip_address
      t.string :path
      t.string :method
      t.string :response_code
      t.timestamps
    end
  end

  def self.down
    drop_table :api_requests
  end
end
