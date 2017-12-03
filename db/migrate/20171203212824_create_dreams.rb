class CreateDreams < ActiveRecord::Migration[5.1]
  def change
    create_table :dreams do |t|
      t.date :date
      t.string :keywords
      t.float :hours_slept
      t.boolean :lucid_dream?
      t.string :summary
      t.integer :user_id
    end
  end
end
