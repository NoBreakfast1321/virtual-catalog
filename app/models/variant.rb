# == Schema Information
#
# Table name: variants
#
#  id             :integer          not null, primary key
#  base           :boolean          default(FALSE), not null
#  code           :string(50)
#  price_cents    :integer          default(0), not null
#  price_currency :string           default("USD"), not null
#  stock_quantity :integer
#  visible        :boolean          default(TRUE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  product_id     :integer          not null
#
# Indexes
#
#  index_variants_on_product_id           (product_id)
#  index_variants_on_product_id_and_base  (product_id) UNIQUE WHERE base = true
#  index_variants_on_product_id_and_code  (product_id,code) UNIQUE WHERE code IS NOT NULL AND code <> ''
#
# Foreign Keys
#
#  product_id  (product_id => products.id) ON DELETE => cascade
#
class Variant < ApplicationRecord
  audited

  include CodeNormalizer

  belongs_to :product

  has_many :variant_properties, -> { order(:position) }, dependent: :destroy
  has_many :properties, through: :variant_properties

  monetize :price_cents

  validates :base, inclusion: { in: [ true, false ] }
  validates :code,
            length: {
              maximum: 50
            },
            uniqueness: {
              scope: :product_id
            },
            allow_blank: true

  validates :price_cents,
            numericality: {
              greater_than_or_equal_to: 0
            },
            presence: true

  validates :stock_quantity,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            },
            allow_nil: true

  validates :visible, inclusion: { in: [ true, false ] }

  validate :ensure_single_base_variant, if: :base?

  scope :non_base, -> { where(base: false) }

  def label
    properties.pluck(:name).join(" / ")
  end

  private

  def ensure_single_base_variant
    if product.variants.where(base: true).where.not(id: id).exists?
      errors.add(:base, :already_exists_for_this_product)
    end
  end
end
