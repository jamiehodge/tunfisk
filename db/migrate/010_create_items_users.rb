Sequel.migration do
  change do
    create_table :items_users do
      foreign_key :item_id, :items, null: false, on_delete: :cascade
      foreign_key :user_id, :users, null: false, on_delete: :cascade
      
      primary_key [:item_id, :user_id]
    end
  end
end

