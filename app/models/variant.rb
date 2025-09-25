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
            if: :secondary?

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
              message: :single_primary_variant
            },
            if: :primary?

  validates :visible, inclusion: { in: [ true, false ] }

  # 5) Domain temporal attributes
  # (none)

  validate :validate_property_group_presence,
           on: %i[create update],
           if: :secondary?

  validate :validate_property_selection, on: %i[create update], if: :secondary?

  before_validation :generate_property_combination,
                    on: %i[create update],
                    if: :secondary?

  scope :primary, -> { where(primary: true) }
  scope :secondary, -> { where(primary: false) }

  def label
    properties.pluck(:name).join(" / ")
  end

  def secondary?
    !primary?
  end

  private

  def validate_property_group_presence
    return if product&.property_groups&.any?

    errors.add(:base, :no_property_group)
  end

  def validate_property_selection
    property_group_ids = product.property_groups.ids
    selected_group_ids = properties.map(&:property_group_id)
    expected_group_ids = selected_group_ids.tally

    each_provided_once =
      property_group_ids.all? { |id| expected_group_ids[id] == 1 }

    no_extra_selection =
      selected_group_ids.all? { |id| property_group_ids.include?(id) }

    each_provided_once && no_extra_selection

    errors.add(:property_ids, :must_select_property)
  end

  def generate_property_combination
    self.property_combination =
      properties
        .sort_by do |property|
          [
            property.property_group.created_at,
            property.property_group.id,
            property.id
          ]
        end
        .map(&:id)
        .join("-")
  end
end
