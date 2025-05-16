class Category < ApplicationRecord
  include FilterableByTimestamp
  include FilterableByVisibility
  include NameNormalizable
  include OrderableByTimestamp

  belongs_to :user

  has_many :product_categories, dependent: :restrict_with_error
  has_many :products, through: :product_categories

  before_destroy :ensure_no_orphans

  validates :visible, inclusion: { in: [ true, false ] }
  validates :name, length: { maximum: 30 }, presence: true, uniqueness: { scope: :user_id }
  validates :description, length: { maximum: 150 }, allow_nil: true

  def self.ransackable_attributes(auth_object = nil)
    %w[ visible name description created_at updated_at ]
  end

  private

  def ensure_no_orphans
    orphaned = products.select { |p| p.categories.count <= 1 }

    if orphaned.any?
      throw :abort
    end
  end
end
