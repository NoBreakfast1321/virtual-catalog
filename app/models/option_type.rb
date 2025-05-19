class OptionType < ApplicationRecord
  include FilterableByTimestamp
  include FilterableByVisibility
  include NameNormalizable
  include OrderableByTimestamp

  belongs_to :product

  validates :visible, inclusion: { in: [ true, false ] }
  validates :name, length: { maximum: 30 }, presence: true, uniqueness: { scope: :product_id }
  validates :min_choices, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :max_choices, numericality: { only_integer: true, greater_than_or_equal_to: :min_choices }, allow_nil: true
end
