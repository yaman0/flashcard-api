require 'rails_helper'

# Test suite for the Card model
RSpec.describe Card, type: :model do
  # Association test
  # ensure an item record belongs to a single card record
  it { should belong_to(:collection) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:front) }
  it { should validate_presence_of(:back) }
end
