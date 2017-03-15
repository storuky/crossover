class Request < ApplicationRecord
  require 'csv'
  include AASM
  belongs_to :user
  belongs_to :category

  has_many :messages
  accepts_nested_attributes_for :messages
  has_many :users, -> { uniq }, through: :messages

  validates :title, presence: true, length: { in: 2..100 }
  validates :category, presence: true
  validates :messages, presence: true

  aasm :column => :status do
    state :opened, :initial => true
    state :closed

    event :close do
      transitions :from => :opened, :to => :closed
    end

    event :open do
      transitions :from => :closed, :to => :opened
    end
  end

  scope :with_status, -> (status) {
    status.downcase!
    if ["opened", "closed"].include? status
      where(status: status)
    end
  }

  scope :with_categories, -> (category_ids = []) {
    if category_ids&.any?
      joins(:category).where(request_categories: {id: category_ids})
    end
  }

  scope :with_users, -> (user_ids = []) {
    if user_ids&.any?
      joins(:user).where(users: {id: user_ids})
    end
  }

  scope :between_dates, -> (date_from, date_end) {
    if date_from && date_end
      where(created_at: DateTime.parse(date_from).beginning_of_day..DateTime.parse(date_end).end_of_day)
    end
  }

  class << self
    def pluck_fields fields = [], except = []
      args = [:id, :title, :updated_at, :status, "request_categories.name", "users.name", :messages_count] + fields - except
      self.joins(:category, :user).pluck *args
    end

    def look_for query, params = {max_matches: 10000}
      if query.present?
        request_ids = Request.search_for_ids(query, params)
        Request.where(id: request_ids)
      else
        Request
      end
    end

    def to_pdf

    end

    def to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << ["id", "created_at", "updated_at", "title", "user_name", "user_email", "status"]
        self.includes(:user).each do |item|
          csv << [item.id, item.created_at, item.updated_at, item.title, item.user&.name, item.user&.email, item.status]
        end
      end
    end
  end

end