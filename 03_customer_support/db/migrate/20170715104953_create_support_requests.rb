class CreateSupportRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :support_requests do |t|
      t.text :subject, null: false
      t.text :description
      t.datetime :closed_at
      t.string :status, null: false
      t.string :severity
      t.string :category

      t.timestamps
    end
  end
end
