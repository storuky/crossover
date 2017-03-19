class Request::Category < ApplicationRecord
  has_many :requests, dependent: :restrict_with_error
  validates :name, presence: true

  class << self
    def pluck_fields
      pluck(:id, :name)
    end
  end
end
