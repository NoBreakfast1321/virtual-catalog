# == Schema Information
#
# Table name: variants
#
#  id                   :integer          not null, primary key
#  code                 :string(50)
#  price_cents          :integer          default(0), not null
#  price_currency       :string           default("USD"), not null
#  primary              :boolean          default(FALSE), not null
#  property_combination :string
#  stock_quantity       :integer
#  visible              :boolean          default(TRUE), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  product_id           :integer          not null
#
# Indexes
#
#  index_variants_on_product_id                           (product_id)
#  index_variants_on_product_id_and_code                  (product_id,code) UNIQUE
#  index_variants_on_product_id_and_primary               (product_id) UNIQUE WHERE "primary" = 1
#  index_variants_on_product_id_and_property_combination  (product_id,property_combination) UNIQUE WHERE "primary" = 0 AND property_combination IS NOT NULL
#
# Foreign Keys
#
#  product_id  (product_id => products.id) ON DELETE => cascade
#
class Variant < ApplicationRecord
  audited

  include CodeNormalizer
  include VisibilityFilterer

  # 1) Associations (FKs)
  belongs_to :product

  has_many :variant_properties, dependent: :destroy
  has_many :properties, through: :variant_properties

  # 2) Identifiers / business keys
  validates :code,
            length: {
              maximum: 50
            },
            uniqueness: {
              scope: %i[product_id]
            },
            allow_blank: true

  validates :property_combination,
            presence: true,
            uniqueness: {
              scope: %i[product_id],
              conditions: -> { where(primary: false) }
            },
            unless: :primary?

  # 3) Domain fields
  monetize :price_cents

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
            allow_blank: true

  # 4) State flags
  validates :primary,
            inclusion: {
              in: [ true, false ]
            },
            uniqueness: {
              scope: %i[product_id],
              conditions: -> { where(primary: true) },
              message: :only_one_primary_variant_can_be_created
            },
            if: :primary?

  validates :visible, inclusion: { in: [ true, false ] }

  # 5) Domain temporal attributes
  # (none)

  validate :ensure_one_selection_per_group
  validate :product_must_have_property_group, on: :create, unless: :primary?

  before_validation :generate_property_combination,
                    on: %i[create update],
                    unless: :primary?

  scope :primary, -> { where(primary: true) }
  scope :secondary, -> { where(primary: false) }

  def label
    properties.pluck(:name).join(" / ")
  end

  def secondary?
    !primary?
  end

  private

  def ensure_one_selection_per_group
    return unless product.present?

    expected_group_ids = product.property_groups.ids

    return unless expected_group_ids.any?

    provided_group_ids = properties.map(&:property_group_id).uniq.compact

    excluded_group_ids = expected_group_ids - provided_group_ids

    return unless excluded_group_ids.any?

    errors.add(:property_ids, :must_select_property)
  end

  def generate_property_combination
    self.property_combination = ordered_properties.map(&:id).join("-")
  end

  def ordered_properties
    properties.to_a.sort_by do |property|
      property_group = property.property_group

      [
        property_group&.created_at || Time.at(0),
        property_group&.id || 0,
        property.id || 0
      ]
    end
  end

  def product_must_have_property_group
    return if product&.property_groups&.any?

    errors.add(:base, :product_without_property_group)
  end
end
