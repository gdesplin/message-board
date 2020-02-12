class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.int :post_id
      t.text :body
      t.int :user_id

      t.timestamps
    end
  end
end
