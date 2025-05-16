class Product < ApplicationRecord
  include FilterableByTimestamp
  include FilterableByVisibility
  include NameNormalizable
  include OrderableByTimestamp

  belongs_to :user

  monetize :price_cents
  monetize :sale_price_cents, allow_nil: true

  validates :visible, inclusion: { in: [ true, false ] }
  validates :featured, inclusion: { in: [ true, false ] }
  validates :code, length: { maximum: 50 }, uniqueness: { scope: :user_id }, allow_nil: true
  validates :name, length: { maximum: 150 }, presence: true, uniqueness: { scope: :user_id }
  validates :description, length: { maximum: 5000 }, allow_nil: true
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :sale_price_cents, numericality: { greater_than_or_equal_to: 0, less_than: :price_cents }, presence: true, if: -> { sale_starts_at.present? }
  validates :sale_starts_at, absence: true, if: -> { sale_price_cents.blank? }
  validates :sale_ends_at, absence: true, if: -> { sale_starts_at.blank? }
  validates :sale_ends_at, comparison: { greater_than: :sale_starts_at }, allow_nil: true
  validates :available_until, absence: true, if: -> { available_from.blank? }
  validates :available_until, comparison: { greater_than: :available_from }, allow_nil: true

  scope :featured, -> { where(featured: true) }
  scope :unfeatured, -> { where(featured: false) }
  scope :on_sale, -> { where.not(sale_price_cents: nil) }
  scope :sale_scheduled, -> { where.not(sale_starts_at: nil).where("sale_starts_at > ?", Time.current) }
  scope :sale_ended, -> { where.not(sale_ends_at: nil).where("sale_ends_at < ?", Time.current) }

  def self.ransackable_attributes(auth_object = nil)
    %w[ visible featured code name description price sale_price sale_starts_at sale_ends_at available_from available_until created_at updated_at ]
  end
end
