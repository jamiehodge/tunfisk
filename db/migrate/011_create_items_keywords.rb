Sequel.migration do
  change do
    create_table :items_keywords do
      foreign_key :item_id, :items, null: false, on_delete: :cascade
      foreign_key :keyword_id, :keywords, null: false, on_delete: :cascade
      
      index [:item_id, :keyword_id]
      unique [:item_id, :keyword_id]
    end
  end
end
