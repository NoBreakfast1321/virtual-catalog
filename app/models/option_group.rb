# == Schema Information
#
# Table name: option_groups
#
#  id          :integer          not null, primary key
#  max_choices :integer
#  min_choices :integer          default(1), not null
#  name        :string(30)       not null
#  visible     :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :integer          not null
#
# Indexes
#
#  index_option_groups_on_product_id           (product_id)
#  index_option_groups_on_product_id_and_name  (product_id,name) UNIQUE
#
# Foreign Keys
#
#  product_id  (product_id => products.id) ON DELETE => cascade
#
class OptionGroup < ApplicationRecord
  audited

  include NameNormalizer
  include VisibilityFilterer

  belongs_to :product

  has_many :options, dependent: :destroy

  validates :max_choices, numericality: { only_integer: true, greater_than_or_equal_to: :min_choices }, allow_nil: true
  validates :min_choices, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :name, length: { maximum: 30 }, presence: true, uniqueness: { scope: :product_id }
  validates :visible, inclusion: { in: [ true, false ] }
end
