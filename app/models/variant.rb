# == Schema Information
#
# Table name: variants
#
#  id             :integer          not null, primary key
#  base           :boolean          default(FALSE), not null
#  code           :string(50)
#  price_cents    :integer          default(0), not null
#  price_currency :string           default("USD"), not null
#  signature      :string
#  stock_quantity :integer
#  visible        :boolean          default(TRUE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  product_id     :integer          not null
#
# Indexes
#
#  index_variants_on_product_id                (product_id)
#  index_variants_on_product_id_and_base       (product_id) UNIQUE WHERE base = true
#  index_variants_on_product_id_and_code       (product_id,code) UNIQUE WHERE code IS NOT NULL AND code <> ''
#  index_variants_on_product_id_and_signature  (product_id,signature) UNIQUE WHERE base = false AND signature IS NOT NULL AND signature <> ''
#
# Foreign Keys
#
#  product_id  (product_id => products.id) ON DELETE => cascade
#
class Variant < ApplicationRecord
  audited

  include CodeNormalizer

  belongs_to :product

  has_many :variant_properties, dependent: :destroy
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

  validates :signature,
            presence: true,
            uniqueness: {
              scope: :product_id
            },
            allow_blank: true

  validates :stock_quantity,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            },
            allow_nil: true

  validates :visible, inclusion: { in: [ true, false ] }

  validate :ensure_property_selection
  validate :ensure_single_base_variant

  before_validation :generate_signature, on: %i[create update]

  scope :base, -> { where(base: true) }
  scope :non_base, -> { where(base: false) }

  def label
    properties.pluck(:name).join(" / ")
  end

  private

  def ensure_property_selection
    return if base?

    return if product.blank?

    return if product.business.blank?

    required_ids = product.business.property_groups.ids.sort
    selected_ids = properties.map(&:property_group_id).uniq.sort

    missing_ids = required_ids - selected_ids

    missing_ids.each { errors.add(:property_ids, :must_select_property) }
  end

  def ensure_single_base_variant
    return unless base?

    if product.variants.where(base: true).where.not(id: id).exists?
      errors.add(:base, :already_exists_for_this_product)
    end
  end

  def generate_signature
    return if base?

    self.signature = properties.pluck(:id).sort.join("-")
  end
end
