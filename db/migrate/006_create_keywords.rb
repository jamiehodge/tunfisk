Sequel.migration do
  up do
    create_table :keywords do
      primary_key :id
      
      String :name, null: false, unique: true
      
      Integer :lock_version, default: 0
        
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
          
      check { char_length(name) > 0 }
      
      full_text_index :name
    end
    
    pgt_created_at :keywords, :created_at
    pgt_updated_at :keywords, :updated_at
  end
  
  down do
    drop_table :keywords
    drop_function "pgt_ca_keywords__created_at", cascade: true
    drop_function "pgt_ua_keywords__updated_at", cascade: true
  end
end
