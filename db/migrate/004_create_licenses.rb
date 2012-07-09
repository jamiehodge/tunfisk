Sequel.migration do
  change do
    create_table :licenses do
      primary_key :id
      
      String  :name, null: false, unique: true
      String  :code, null: false, unique: true
      
      check { char_length(name) > 0 }
      check { char_length(code) > 0 }
    end
  end
end
