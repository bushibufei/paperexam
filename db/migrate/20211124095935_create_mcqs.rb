class CreateMcqs < ActiveRecord::Migration
  def change
    create_table :mcqs do |t|
    
      t.text :title
    
      t.timestamps null: false
    end
  end
end
