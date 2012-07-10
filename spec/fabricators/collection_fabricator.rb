Fabricator :collection do
  title       { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraph }
  department  { Faker::Lorem.sentence }
  institution
  language
  license
end
