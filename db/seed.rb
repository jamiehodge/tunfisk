# encoding: UTF-8

DB.transaction do
  
  # Top-level
  {
    '100' => 'Business',
    '101' => 'Engineering',
    '102' => 'Fine Arts',
    '103' => 'Health & Medicine',
    '104' => 'History',
    '105' => 'Humanities',
    '106' => 'Language',
    '107' => 'Literature',
    '108' => 'Mathematics',
    '109' => 'Science',
    '110' => 'Social Science',
    '111' => 'Society',
    '112' => 'Teaching & Education'
  }.each do |code, name|
    DB[:categories].insert code: code, name: name
  end

  # Business
  {
    '100' => 'Economics',
    '101' => 'Finance',
    '102' => 'Hospitality',
    '103' => 'Management',
    '104' => 'Marketing',
    '105' => 'Personal Finance',
    '106' => 'Real Estate'
  }.each do |code, name|
    DB[:subcategories].insert code: code, name: name, category_id: DB[:categories].first(code: 100)[:id]
  end

  # Engineering
  {
    '100' => 'Chemical & Petroleum',
    '101' => 'Civil',
    '102' => 'Computer Science',
    '103' => 'Electrical',
    '104' => 'Environmental',
    '105' => 'Mechanical'
  }.each do |code, name|
    DB[:subcategories].insert code: code, name: name, category_id: DB[:categories].first(code: 101)[:id]
  end

  # Fine Arts
  {
    '100' => 'Architecture',
    '101' => 'Art',
    '102' => 'Art History',
    '103' => 'Dance',
    '104' => 'Film',
    '105' => 'Graphic Design',
    '106' => 'Interior Design',
    '107' => 'Music',
    '108' => 'Theater'
  }.each do |code, name|
    DB[:subcategories].insert code: code, name: name, category_id: DB[:categories].first(code: 102)[:id]
  end

  # Health & Medicine
  {
    '100' => 'Anatomy & Physiology',
    '101' => 'Behavioral Science',
    '102' => 'Dentistry',
    '103' => 'Diet & Nutrition',
    '104' => 'Emergency',
    '105' => 'Genetics',
    '106' => 'Gerontology',
    '107' => 'Health & Exercise Science',
    '108' => 'Immunology',
    '109' => 'Neuroscience',
    '110' => 'Pharmacology & Toxicology',
    '111' => 'Psychiatry',
    '112' => 'Public Health',
    '113' => 'Radiology'
  }.each do |code, name|
    DB[:subcategories].insert code: code, name: name, category_id: DB[:categories].first(code: 103)[:id]
  end

  # History
  {
    '100' => 'Ancient',
    '101' => 'Medieval',
    '102' => 'Military',
    '103' => 'Modern',
    '104' => 'African',
    '105' => 'Asian',
    '106' => 'European',
    '107' => 'Middle Eastern',
    '108' => 'North American',
    '109' => 'South American'
  }.each do |code, name|
    DB[:subcategories].insert code: code, name: name, category_id: DB[:categories].first(code: 104)[:id]
  end

  # Humanities
  {
    '100' => 'Communications',
    '101' => 'Philosophy',
    '102' => 'Religion'
  }.each do |code, name|
    DB[:subcategories].insert code: code, name: name, category_id: DB[:categories].first(code: 105)[:id]
  end

  # Language
  {
    '100' => 'African',
    '101' => 'Ancient',
    '102' => 'Asian',
    '103' => 'Eastern European/Slavic',
    '104' => 'English',
    '105' => 'English Language Learners',
    '106' => 'French',
    '107' => 'German',
    '108' => 'Italian',
    '109' => 'Linguistics',
    '110' => 'Middle Eastern',
    '111' => 'Spanish & Portuguese',
    '112' => 'Speech Pathology'
  }.each do |code, name|
    DB[:subcategories].insert code: code, name: name, category_id: DB[:categories].first(code: 106)[:id]
  end

  # Literature
  {
    '100' => 'Anthologies',
    '101' => 'Biography',
    '102' => 'Classics',
    '103' => 'Criticism',
    '104' => 'Fiction',
    '105' => 'Poetry'
  }.each do |code, name|
    DB[:subcategories].insert code: code, name: name, category_id: DB[:categories].first(code: 107)[:id]
  end


  # Mathematics
  {
    '100' => 'Advanced Mathematics',
    '101' => 'Algebra',
    '102' => 'Arithmetic',
    '103' => 'Calculus',
    '104' => 'Geometry',
    '105' => 'Statistics'
  }.each do |code, name|
    DB[:subcategories].insert code: code, name: name, category_id: DB[:categories].first(code: 108)[:id]
  end

  # Science
  {
    '100' => 'Agricultural',
    '101' => 'Astronomy',
    '102' => 'Atmospheric',
    '103' => 'Biology',
    '104' => 'Chemistry',
    '105' => 'Ecology',
    '106' => 'Geography',
    '107' => 'Geology',
    '108' => 'Physics'
  }.each do |code, name|
    DB[:subcategories].insert code: code, name: name, category_id: DB[:categories].first(code: 109)[:id]
  end

  # Social Science
  {
    '100' => 'Law',
    '101' => 'Political Science',
    '102' => 'Public Administration',
    '103' => 'Psychology',
    '104' => 'Social Welfare',
    '105' => 'Sociology'
  }.each do |code, name|
    DB[:subcategories].insert code: code, name: name, category_id: DB[:categories].first(code: 110)[:id]
  end

  # Society
  {
    '100' => 'African-American Studies',
    '101' => 'Asian Studies',
    '102' => 'European & Russian Studies',
    '103' => 'Indigenous Studies',
    '104' => 'Latin & Caribbean Studies',
    '105' => 'Middle Eastern Studies',
    '106' => "Women's Studies"
  }.each do |code, name|
    DB[:subcategories].insert code: code, name: name, category_id: DB[:categories].first(code: 111)[:id]
  end


  # Teaching & Education
  {
    '100' => 'Curriculum & Teaching',
    '101' => 'Educational Leadership',
    '102' => 'Family & Childcare',
    '103' => 'Learning Resources',
    '104' => 'Psychology & Research',
    '105' => 'Special Education'
  }.each do |code, name|
    DB[:subcategories].insert code: code, name: name, category_id: DB[:categories].first(code: 112)[:id]
  end
  
end
