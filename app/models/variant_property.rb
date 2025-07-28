# == Schema Information
#
# Table name: variant_properties
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  property_id :integer          not null
#  variant_id  :integer          not null
#
# Indexes
#
#  index_variant_properties_on_property_id                 (property_id)
#  index_variant_properties_on_property_id_and_variant_id  (property_id,variant_id)
#  index_variant_properties_on_variant_id                  (variant_id)
#  index_variant_properties_on_variant_id_and_property_id  (variant_id,property_id) UNIQUE
#
# Foreign Keys
#
#  property_id  (property_id => properties.id) ON DELETE => cascade
#  variant_id   (variant_id => variants.id) ON DELETE => cascade
#
class VariantProperty < ApplicationRecord
  belongs_to :property
  belongs_to :variant

  validates :property, presence: true
  validates :variant, presence: true

  validates :property_id, uniqueness: { scope: :variant_id }
end
