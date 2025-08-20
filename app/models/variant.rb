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
#  index_variants_on_product_id_and_code       (product_id,code) UNIQUE
#  index_variants_on_product_id_and_signature  (product_id,signature) UNIQUE WHERE base = 0 AND signature IS NOT NULL
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
              scope: :product_id,
              conditions: -> { where(base: false) }
            },
            unless: :base?

  validates :stock_quantity,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            },
            allow_nil: true

  validates :visible, inclusion: { in: [ true, false ] }

  validate :ensure_one_selection_per_group
  validate :product_must_have_property_group, on: :create, unless: :base?
  validate :relocate_signature_error, if: -> { errors[:signature].any? }

  before_validation :generate_signature, on: %i[create update], unless: :base?

  scope :base, -> { where(base: true) }
  scope :non_base, -> { where(base: false) }

  def label
    properties.pluck(:name).join(" / ")
  end

  private

  def ensure_one_selection_per_group
    return if product.nil?

    expected_group_ids = product.property_groups.ids

    return if expected_group_ids.empty?

    provided_group_ids = properties.map(&:property_group_id).uniq.compact

    excluded_group_ids = expected_group_ids - provided_group_ids

    return if excluded_group_ids.empty?

    errors.add(:property_ids, :must_select_property)
  end

  def generate_signature
    self.signature = ordered_properties.map(&:id).join("-")
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
    return if product&.property_groups&.exists?

    # TODO: Find a way to better display this error in the UI.
    errors.add(:base, :product_without_property_group)
  end

  # TODO: Remove once UI properly displays error messages (condensed form has limited space).
  def relocate_signature_error
    errors.delete(:signature)
    errors.add(:property_ids, :property_combination_already_used)
  end
end
