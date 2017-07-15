class CreateSupportRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :support_requests do |t|
      t.text :subject, null: false
      t.text :description
      t.datetime :closed_at
      t.string :status, null: false
      t.string :severity
      t.string :category
      t.integer :customer_id, null: false
      t.integer :agent_id, null: true

      t.timestamps
    end

    add_index :support_requests, :customer_id
    add_index :support_requests, :agent_id
  end

end
