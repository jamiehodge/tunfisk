Fabricator :item do
  title       'Example Item'
  description 'For testing purposes'
  explicit    false
  collection
  category    Category.first
  subcategory Category.first.subcategories.first
end
