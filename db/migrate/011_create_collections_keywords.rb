Sequel.migration do
  change do
    create_table :collections_keywords do
      foreign_key :collection_id, :collections, null: false, on_delete: :cascade
      foreign_key :keyword_id, :keywords, null: false, on_delete: :cascade
      
      index [:collection_id, :keyword_id]
      unique [:collection_id, :keyword_id]
    end
  end
end
