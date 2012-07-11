Sequel.migration do
  change do
    create_table :collections_links do
      foreign_key :collection_id, :collections, null: false, on_delete: :cascade
      foreign_key :link_id, :links, null: false, on_delete: :cascade
      
      index [:collection_id, :link_id]
      unique [:collection_id, :link_id]
    end
  end
end
