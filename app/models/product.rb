# == Schema Information
#
# Table name: products
#
#  id              :integer          not null, primary key
#  adult_only      :boolean          default(FALSE), not null
#  available_from  :datetime
#  available_until :datetime
#  code            :string(50)
#  description     :text(5000)
#  featured        :boolean          default(FALSE), not null
#  name            :string(150)      not null
#  slug            :string(150)      not null
#  visible         :boolean          default(TRUE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  catalog_id      :integer          not null
#
# Indexes
#
#  index_products_on_catalog_id           (catalog_id)
#  index_products_on_catalog_id_and_code  (catalog_id,code) UNIQUE
#  index_products_on_catalog_id_and_name  (catalog_id,name) UNIQUE
#  index_products_on_catalog_id_and_slug  (catalog_id,slug) UNIQUE
#
# Foreign Keys
#
#  catalog_id  (catalog_id => catalogs.id) ON DELETE => cascade
#
class Product < ApplicationRecord
  audited

  include CodeNormalizer
  include NameNormalizer
  include SlugRestricter
  include VisibilityFilterer

  # 1) Associations (FKs)
  belongs_to :catalog

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  has_many :product_option_groups, dependent: :destroy
  has_many :option_groups, through: :product_option_groups

  has_many :product_property_groups, dependent: :destroy
  has_many :property_groups, through: :product_property_groups

  has_many :variants, dependent: :destroy

  validates :categories, presence: true

  # 2) Identifiers / business keys
  validates :name,
            presence: true,
            length: {
              maximum: 150
            },
            uniqueness: {
              scope: %i[catalog_id]
            }

  validates :slug,
            presence: true,
            length: {
              maximum: 150
            },
            uniqueness: {
              scope: %i[catalog_id]
            }

  validates :code,
            length: {
              maximum: 50
            },
            uniqueness: {
              scope: %i[catalog_id]
            }

  # 3) Domain fields
  validates :description, length: { maximum: 5000 }

  has_many_attached :images

  validates :images,
            content_type: {
              in: %w[image/jpeg image/png image/webp],
              spoofing_protection: true
            },
            size: {
              less_than: 1.megabyte
            },
            limit: {
              max: 10
            }

  # 4) State flags
  validates :adult_only, inclusion: { in: [ true, false ] }
  validates :featured, inclusion: { in: [ true, false ] }
  validates :visible, inclusion: { in: [ true, false ] }

  # 5) Domain temporal attributes
  validates :available_until,
            comparison: {
              greater_than: :available_from
            },
            if: -> { available_from.present? && available_until.present? }

  before_validation :generate_slug, on: %i[create update]

  # 🔞 Audience scopes
  scope :adult, -> { where(adult_only: true) }
  scope :not_adult, -> { where(adult_only: false) }

  # 📆 Availability scopes
  scope :available,
        -> do
          where(
            "available_from IS NULL OR available_from <= :now",
            now: Time.current,
          )
        end

  scope :not_available,
        -> do
          where(
            "available_from IS NOT NULL AND available_from > :now",
            now: Time.current,
          )
        end

  scope :expired,
        -> do
          where(
            "available_until IS NOT NULL AND available_until < :now",
            now: Time.current,
          )
        end

  scope :not_expired,
        -> do
          where(
            "available_until IS NULL OR available_until >= :now",
            now: Time.current,
          )
        end

  # 🔥 Featured scopes
  scope :featured, -> { where(featured: true) }
  scope :not_featured, -> { where(featured: false) }

  # 🚩 General state scopes
  scope :active, -> { visible.available.not_expired }

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      name
      slug
      code
      description
      adult_only
      featured
      visible
      available_from
      available_until
      created_at
      updated_at
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[categories]
  end

  def primary_variant
    variants.find_by(primary: true)
  end

  def active?
    visible? && available? && !expired?
  end

  def available?
    return true unless available_from.present?

    available_from <= Time.current
  end

  def expired?
    return false unless available_until.present?

    available_until < Time.current
  end

  private

  def generate_slug
    self.slug = name.parameterize[0..49]

    unless slug.present?
      errors.add(:name, :cannot_be_used_to_generate_valid_slug)

      throw(:abort)
    end
  end
end
