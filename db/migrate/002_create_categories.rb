Sequel.migration do
  change do
    create_table :categories do
      primary_key :id
      
      Integer :code, null: false, unique: true
      String  :name, null: false
      
      check { char_length(name) > 0 }
    end
    
    create_table :subcategories do
      primary_key :id
      foreign_key :category_id, :categories,
        null: false, on_delete: :cascade
      
      Integer :code, null: false
      String  :name, null: false
      
      check { char_length(name) > 0 }
      
      unique [:category_id, :code]
    end
  end
end
