Sequel.migration do
  up do
    create_table :items do
      primary_key :id
      
      foreign_key :collection_id, :collections, null: false, on_delete: :cascade, index: true
      foreign_key :category_id, :categories, null: false
      foreign_key :subcategory_id, :subcategories, null: false
        
      String      :title,       null: false
      String      :description, null: false, text: true
      FalseClass  :explicit,    default: false
      
      Integer     :lock_version, default: 0
      
      DateTime    :created_at, null: false
      DateTime    :updated_at, null: false
      
      check { char_length(:title) > 0 }
      check { char_length(:description) > 0 }
      
      full_text_index [:title, :description]
      
      index [:category_id, :subcategory_id]
    end
    
    pgt_created_at :items, :created_at
    pgt_updated_at :items, :updated_at
  end
  
  down do
    drop_table :items
    drop_function "pgt_ca_items__created_at", cascade: true
    drop_function "pgt_ua_items__updated_at", cascade: true
  end
end
