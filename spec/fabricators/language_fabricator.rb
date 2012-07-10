Fabricator :language do
  code  { (0...2).map{65.+(rand(25)).chr}.join }
  name  { Faker::Lorem.sentence }
end