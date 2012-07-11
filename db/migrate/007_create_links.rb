Sequel.migration do
  up do
    create_table :links do
      primary_key :id
      
      String :name, null: false
      String :url, null: false, unique: true
      
      Integer :lock_version, default: 0
        
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
          
      check { char_length(name) > 0 }
      check { :url.like(/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/) }
      
      full_text_index :name
    end
    
    pgt_created_at :links, :created_at
    pgt_updated_at :links, :updated_at
  end
  
  down do
    drop_table :links
    drop_function "pgt_ca_links__created_at", cascade: true
    drop_function "pgt_ua_links__updated_at", cascade: true
  end
end

