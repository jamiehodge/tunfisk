Sequel.migration do
  change do
    create_table :users do
      primary_key :id
      
      String  :username
      
      check { :username.like(/^[a-z]{3}\d{3}$/) }
      
      unique :username
    end
  end
end
