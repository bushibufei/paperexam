class CreateMcqOptions < ActiveRecord::Migration
  def change
    create_table :mcq_options do |t|
    
      t.text :title
    
      t.boolean :answer,  null: false, default: false 
    

    

    

    
      t.references :mcq
    

    
      t.timestamps null: false
    end
  end
end
