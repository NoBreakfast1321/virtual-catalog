# == Schema Information
#
# Table name: option_values
#
#  id                       :integer          not null, primary key
#  name                     :string(50)       not null
#  price_variation_cents    :integer
#  price_variation_currency :string           default("USD")
#  visible                  :boolean          default(TRUE), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  option_type_id           :integer          not null
#
# Indexes
#
#  index_option_values_on_option_type_id           (option_type_id)
#  index_option_values_on_option_type_id_and_name  (option_type_id,name) UNIQUE
#
# Foreign Keys
#
#  option_type_id  (option_type_id => option_types.id) ON DELETE => cascade
#
class OptionValue < ApplicationRecord
  include FilterableByTimestamp
  include FilterableByVisibility
  include NameNormalizable
  include OrderableByTimestamp

  belongs_to :option_type

  monetize :price_variation_cents, allow_nil: true

  validates :visible, inclusion: { in: [ true, false ] }
  validates :name, length: { maximum: 50 }, presence: true, uniqueness: { scope: :option_type }
end
