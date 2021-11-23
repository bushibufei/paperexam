class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
    
      t.string :name,  null: false, default: Setting.systems.default_str
    
      t.datetime :exmdate
    
      t.text :desc
    

    

    

    

    
      t.references :user
    
      t.timestamps null: false
    end
  end
end
