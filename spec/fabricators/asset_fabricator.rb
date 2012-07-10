Fabricator :asset do
  name  { Faker::Internet.domain_name }
  type  { MIME::Types[%r{^(image|video|audio)}].sample }
  size  { rand 10000 }
  item
end
