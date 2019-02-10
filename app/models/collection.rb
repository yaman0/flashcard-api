class Collection < ApplicationRecord
  has_many :cards, dependent: :destroy

  validates_presence_of :title, :created_by
end
