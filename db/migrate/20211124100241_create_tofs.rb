class CreateTofs < ActiveRecord::Migration
  def change
    create_table :tofs do |t|
    
      t.text :title
    
      t.boolean :answer,  null: false, default: false 
    

    
      t.timestamps null: false
    end
  end
end
