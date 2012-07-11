Fabricator :link do
  name  { Faker::Company.name }
  url   { "http://#{Faker::Internet.domain_name}" }
end