Sequel.migration do
  change do
    create_table :users do
      primary_key :id
      
      String  :username, null: false, unique: true
      
      check { :username.like(/^[a-z]{3}\d{3}$/) }
    end
  end
end
