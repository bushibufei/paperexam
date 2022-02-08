class CreateAdvises < ActiveRecord::Migration
  def change
    create_table :advises do |t|
    
      t.string :title,  null: false, default: Setting.systems.default_str
    
      t.text :content
    

    

    

    
      t.references :user
    

    
      t.references :user
    
      t.timestamps null: false
    end
  end
end
