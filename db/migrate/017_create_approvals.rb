Sequel.migration do
  up do
    create_table :approvals do
      primary_key :id
        
      foreign_key :asset_id, :assets, null: false, on_delete: :cascade, index: true
      foreign_key :reviewer_id, :users, null: false, on_delete: :cascade, index: true
      foreign_key :status_id, :statuses, null: false, index: true
      
      String :comment, text: true
      
      Integer :lock_version, default: 0
      
      DateTime :created_at
      DateTime :updated_at
      
      full_text_index :comment
      
      unique [:asset_id, :reviewer_id]
    end
    
    pgt_created_at :approvals, :created_at
    pgt_updated_at :approvals, :updated_at
  end
  
  down do
    drop_table :approvals
    drop_function "pgt_ca_approvals__created_at", cascade: true
    drop_function "pgt_ua_approvals__updated_at", cascade: true
  end
end

