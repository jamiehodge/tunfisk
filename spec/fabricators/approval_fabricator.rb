Fabricator :approval do
  comment  { Faker::Lorem.paragraph }
  reviewer { Fabricate :user }
  asset
  status
end
