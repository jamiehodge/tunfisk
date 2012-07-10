Fabricator :item do
  title       { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraph }
  explicit    { [true, false].sample }
  collection
  category
  subcategory
  institution
end
