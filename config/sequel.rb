DB = Sequel.connect "#{ENV['DATABASE_URL']}-#{ENV['RACK_ENV']}"
DB.optimize_model_load = true

Sequel.instance_eval do
  extension :blank
  extension :pagination
end

Sequel::Model.instance_eval do
  self.raise_on_typecast_failure = false
  self.strict_param_setting = false
  
  plugin :prepared_statements
  plugin :prepared_statements_associations
  
  plugin :boolean_readers
  plugin :string_stripper
  
  plugin :json_serializer
  
  plugin :validation_helpers
end
