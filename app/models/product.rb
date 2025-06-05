# == Schema Information
#
# Table name: products
#
#  id                  :integer          not null, primary key
#  available_from      :datetime
#  available_until     :datetime
#  code                :string(50)
#  description         :text(5000)
#  featured            :boolean          default(FALSE), not null
#  name                :string(150)      not null
#  price_cents         :integer          default(0), not null
#  price_currency      :string           default("USD"), not null
#  sale_ends_at        :datetime
#  sale_price_cents    :integer
#  sale_price_currency :string
#  sale_starts_at      :datetime
#  visible             :boolean          default(TRUE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  business_id         :integer          not null
#
# Indexes
#
#  index_products_on_business_id           (business_id)
#  index_products_on_business_id_and_code  (business_id,code) UNIQUE WHERE code IS NOT NULL AND code <> ''
#  index_products_on_business_id_and_name  (business_id,name) UNIQUE
#
# Foreign Keys
#
#  business_id  (business_id => businesses.id) ON DELETE => cascade
#
class Product < ApplicationRecord
  include FilterableByVisibility
  include NameNormalizable

  belongs_to :business

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :option_groups, dependent: :destroy

  before_validation :normalize_code

  monetize :price_cents
  monetize :sale_price_cents, allow_nil: true

  validates :visible, inclusion: { in: [ true, false ] }
  validates :featured, inclusion: { in: [ true, false ] }
  validates :code, length: { maximum: 50 }, uniqueness: { scope: :business_id }, allow_blank: true
  validates :name, length: { maximum: 150 }, presence: true, uniqueness: { scope: :business_id }
  validates :description, length: { maximum: 5000 }, allow_blank: true
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :sale_price_cents, numericality: { greater_than_or_equal_to: 0, less_than: :price_cents }, presence: true, if: -> { sale_starts_at.present? }
  validates :sale_starts_at, absence: true, if: -> { sale_price_cents.blank? }
  validates :sale_ends_at, absence: true, if: -> { sale_starts_at.blank? }
  validates :sale_ends_at, comparison: { greater_than: :sale_starts_at }, allow_nil: true
  validates :available_until, absence: true, if: -> { available_from.blank? }
  validates :available_until, comparison: { greater_than: :available_from }, allow_nil: true
  validates :categories, presence: true

  scope :featured, -> { where(featured: true) }
  scope :unfeatured, -> { where(featured: false) }
  scope :on_sale, -> { where.not(sale_price_cents: nil) }
  scope :sale_scheduled, -> { where.not(sale_starts_at: nil).where("sale_starts_at > ?", Time.current) }
  scope :sale_ended, -> { where.not(sale_ends_at: nil).where("sale_ends_at < ?", Time.current) }
  scope :available, -> { where("available_from IS NULL OR available_from <= ?", Time.current) }
  scope :expired, -> { where.not(available_until: nil).where("available_until < ?", Time.current) }
  scope :not_expired, -> { where("available_until IS NULL OR available_until >= ?", Time.current) }
  scope :active, -> { visible.available.not_expired }

  def self.ransackable_attributes(auth_object = nil)
    %w[ visible featured code name description price sale_price sale_starts_at sale_ends_at available_from available_until created_at updated_at ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[ categories ]
  end

  def active?
    visible &&
      (available_from.nil? || available_from <= Time.current) &&
      (available_until.nil? || available_until >= Time.current)
  end

  def effective_price
    sale_price.presence || price
  end

  private

  def normalize_code
    self.code = code&.strip&.presence
  end
end
