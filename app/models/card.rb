class Card < ApplicationRecord
  belongs_to :collection

  validates_presence_of :front, :back
end
