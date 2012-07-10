Fabricator :approval do
  comment  { Faker::Lorem.paragraph }
  reviewer { Fabricate :user }
  item
  status
end
