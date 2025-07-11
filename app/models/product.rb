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
#  business_id     :integer          not null
#
# Indexes
#
#  index_products_on_business_id           (business_id)
#  index_products_on_business_id_and_code  (business_id,code) UNIQUE WHERE code IS NOT NULL AND code <> ''
#  index_products_on_business_id_and_name  (business_id,name) UNIQUE
#  index_products_on_business_id_and_slug  (business_id,slug) UNIQUE
#
# Foreign Keys
#
#  business_id  (business_id => businesses.id) ON DELETE => cascade
#
class Product < ApplicationRecord
  include CodeNormalizer
  include NameNormalizer
  include SlugRestricter
  include VisibilityFilterer

  has_many_attached :images

  belongs_to :business

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  has_many :option_groups, dependent: :destroy
  has_many :property_groups, dependent: :destroy

  has_many :properties, through: :property_groups

  has_many :variants, dependent: :destroy

  validates :images,
    limit: { max: 10 },
    content_type: { in: [ "image/jpeg", "image/png", "image/webp" ], spoofing_protection: true },
    size: { less_than: 1.megabyte }

  validates :adult_only, inclusion: { in: [ true, false ] }
  validates :available_until, absence: true, if: -> { available_from.nil? }
  validates :available_until, comparison: { greater_than: :available_from }, allow_nil: true
  validates :code, length: { maximum: 50 }, uniqueness: { scope: :business_id }, allow_blank: true
  validates :description, length: { maximum: 5000 }, allow_blank: true
  validates :featured, inclusion: { in: [ true, false ] }
  validates :name, length: { maximum: 150 }, presence: true, uniqueness: { scope: :business_id }
  validates :slug, length: { maximum: 150 }, presence: true, uniqueness: { scope: :business_id }
  validates :visible, inclusion: { in: [ true, false ] }
  validates :categories, presence: true

  before_validation :generate_slug, on: %i[ create update ]
  before_validation :normalize_code

  # 🔞 Audience scopes
  scope :adult, -> { where(adult_only: true) }
  scope :non_adult, -> { where(adult_only: false) }

  # 📆 Availability scopes
  scope :available, -> { where("available_from IS NULL OR available_from <= ?", Time.current) }
  scope :expired, -> { where.not(available_until: nil).where(available_until: ...Time.current) }
  scope :not_expired, -> { where("available_until IS NULL OR available_until >= ?", Time.current) }

  # 🔥 Featured scopes
  scope :featured, -> { where(featured: true) }
  scope :unfeatured, -> { where(featured: false) }

  # 🚩 General state scopes
  scope :active, -> { visible.available.not_expired }

  def self.ransackable_attributes(auth_object = nil)
    %w[ available_from available_until code description featured name slug visible created_at updated_at ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[ categories ]
  end

  def active?
    return false unless visible

    return false if available_from && available_from > Time.current

    return false if available_until && available_until < Time.current

    true
  end

  def base_variant
    variants.find_by(base: true)
  end

  private

  def generate_slug
    self.slug = name.parameterize[0..49]

    if slug.blank?
      errors.add(:name, "cannot be used to generate a valid slug")

      throw(:abort)
    end
  end
end
