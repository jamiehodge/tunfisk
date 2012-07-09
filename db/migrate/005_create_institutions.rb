Sequel.migration do
  change do
    create_table :institutions do
      primary_key :id
      
      String  :name, null: false, unique: true
      
      check { char_length(name) > 0 }
    end
  end
end
