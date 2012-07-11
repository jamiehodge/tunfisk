Sequel.migration do
  up do
    create_table :proxies do
      primary_key :id
      
      foreign_key :asset_id, :assets, null: false, on_delete: :cascade, index: true
      
      String      :name, null: false
      String      :type, null: false, index: true
      Fixnum      :size, null: false
      
      Integer     :lock_version, default: 0
      
      DateTime    :created_at, null: false
      DateTime    :updated_at, null: false
      
      check { char_length(name) > 0 }
      check { :type.like(/^[-\w.+]+\/[-\w.+]*$/) }
      check { size > 0 }
    end

    pgt_created_at :proxies, :created_at
    pgt_updated_at :proxies, :updated_at
  end
  
  down do
    drop_table :proxies
    drop_function "pgt_ca_proxies__created_at", cascade: true
    drop_function "pgt_ua_proxies__updated_at", cascade: true
  end
end

