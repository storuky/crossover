class Request < ApplicationRecord
  include AASM
  belongs_to :user
  belongs_to :category

  has_many :messages
  accepts_nested_attributes_for :messages

  validates :title, presence: true, length: { in: 2..100 }
  validates :category, presence: true
  validates :messages, presence: true

  aasm :column => :status do
    state :opened, :initial => true
    state :closed

    event :close do
      transitions :from => :opened, :to => :closed
    end
  end

  class << self
    def pluck_fields fields = [], except = []
      args = [:id, :title, :created_at, :status, "request_categories.name"] + fields - except
      self.joins(:category).pluck *args
    end

    def look_for query, params = {max_matches: 10000}
      if query.present?
        request_ids = Request.search_for_ids(query, params)
        Request.where(id: request_ids)
      else
        Request
      end
    end
  end

end