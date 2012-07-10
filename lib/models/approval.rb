class Approval < Sequel::Model

  many_to_one :item
  many_to_one :reviewer, class: User
  many_to_one :status
  
  Status.each do |status|
    subset status.to_sym, status: Status.const_get(status.upcase)
  end
  
  plugin :optimistic_locking
  
  def validate
    super
    validates_presence [:item_id, :reviewer_id, :status_id]
    validates_unique   [:item_id, :reviewer_id]
  end
  
  def_dataset_method(:text_search) do |query|
    return self if query.blank?
    full_text_search([:comment], query.split.map {|q| "#{q}:*"})
  end
  
end
