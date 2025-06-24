# == Schema Information
#
# Table name: variants
#
#  id                      :integer          not null, primary key
#  code                    :string(50)
#  price_override_cents    :integer
#  price_override_currency :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  product_id              :integer          not null
#
# Indexes
#
#  index_variants_on_product_id  (product_id)
#
# Foreign Keys
#
#  product_id  (product_id => products.id) ON DELETE => cascade
#
class Variant < ApplicationRecord
  monetize :price_override_cents, allow_nil: true

  belongs_to :product

  has_many :variant_properties, dependent: :destroy
  has_many :properties, through: :variant_properties

  validates :code, length: { maximum: 50 }, uniqueness: { scope: :business_id }, allow_blank: true

  def label
    properties.pluck(:name).join(" / ")
  end
end
