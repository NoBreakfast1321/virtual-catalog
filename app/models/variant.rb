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
#  index_variants_on_product_id_and_base       (product_id) UNIQUE WHERE base = 1
#  index_variants_on_product_id_and_code       (product_id,code) UNIQUE WHERE NULLIF(TRIM(code), '') IS NOT NULL
#  index_variants_on_product_id_and_signature  (product_id,signature) UNIQUE WHERE base = 0 AND NULLIF(TRIM(signature), '') IS NOT NULL
#
# Foreign Keys
#
#  product_id  (product_id => products.id) ON DELETE => cascade
#
class Variant < ApplicationRecord
  audited

  include CodeNormalizer
  include VisibilityFilterer

  belongs_to :product

  has_many :variant_properties, dependent: :destroy
  has_many :properties, through: :variant_properties

  monetize :price_cents

  validates :base,
            inclusion: {
              in: [ true, false ]
            },
            uniqueness: {
              scope: :product_id,
              conditions: -> { where(base: true) },
              message: :only_one_base_variant_can_be_created
            },
            if: :base?

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

  validate :ensure_one_selection_per_group

  before_validation :generate_signature, on: %i[create update]

  scope :base, -> { where(base: true) }
  scope :non_base, -> { where(base: false) }

  def label
    properties.pluck(:name).join(" / ")
  end

  private

  def ensure_one_selection_per_group
    business = product&.business

    return if business.blank?

    required_ids = business.property_groups.select(:id).pluck(:id).sort

    selected_ids =
      properties
        .select(:property_group_id)
        .distinct
        .pluck(:property_group_id)
        .sort

    missing_ids = required_ids - selected_ids

    return if missing_ids.empty?

    missing_ids.each { errors.add(:property_ids, :must_select_property) }
  end

  def generate_signature
    return if base?

    self.signature = properties.pluck(:id).sort.join("-")
  end
end
