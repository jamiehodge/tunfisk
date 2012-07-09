Sequel.migration do
  change do
    create_table :languages do
      primary_key :id
      
      String  :code, null: false, unique: true, length: 2
      String  :name, null: false, unique: true
      
      check { char_length(code) > 0 }
      check { char_length(name) > 0 }
    end
  end
end
