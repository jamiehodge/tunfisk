Sequel.migration do
  up do
    create_table :assets do
      primary_key :id
      
      foreign_key :item_id, :items, null: false, on_delete: :cascade, index: true
        
      String      :name, null: false
      String      :type, null: false, index: true
      Fixnum      :size, null: false
      
      Integer     :lock_version, default: 0
      
      DateTime    :created_at, null: false
      DateTime    :updated_at, null: false
      
      check { char_length(name) > 0 }
      check { :type.like(/^[-\w.+]+\/[-\w.+]*$/) }
      check { size > 0 }
      
      full_text_index [:name]
    end
    
    pgt_created_at :assets, :created_at
    pgt_updated_at :assets, :updated_at
  end
  
  down do
    drop_table :assets
    drop_function "pgt_ca_assets__created_at", cascade: true
    drop_function "pgt_ua_assets__updated_at", cascade: true
  end
end
