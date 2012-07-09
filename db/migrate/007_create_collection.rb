Sequel.migration do
  up do
    create_table :collections do
      primary_key :id
      
      foreign_key :institution_id, :institutions, null: false, index: true
      foreign_key :language_id, :languages, null: false, index: true
      foreign_key :license_id, :licenses, null: false, index: true
        
      String      :title,       null: false
      String      :description, null: false, text: true
      String      :department,  null: false
      
      Integer     :lock_version, default: 0
      
      DateTime    :created_at, null: false
      DateTime    :updated_at, null: false
      
      check { char_length(title) > 0 }
      check { char_length(description) > 0 }
      check { char_length(department) > 0 }
      
      full_text_index [:title, :description, :department]
    end
    
    pgt_created_at :collections, :created_at
    pgt_updated_at :collections, :updated_at
  end
  
  down do
    drop_table :collections
    drop_function "pgt_ca_collections__created_at", cascade: true
    drop_function "pgt_ua_collections__updated_at", cascade: true
  end
end
