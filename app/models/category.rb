# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  description :text(150)
#  name        :string(30)       not null
#  visible     :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  catalog_id  :integer          not null
#
# Indexes
#
#  index_categories_on_catalog_id           (catalog_id)
#  index_categories_on_catalog_id_and_name  (catalog_id,name) UNIQUE
#
# Foreign Keys
#
#  catalog_id  (catalog_id => catalogs.id) ON DELETE => cascade
#
class Category < ApplicationRecord
  audited

  include NameNormalizer
  include VisibilityFilterer

  # 1) Associations (FKs)
  belongs_to :catalog

  has_many :product_categories, dependent: :restrict_with_error
  has_many :products, through: :product_categories

  # 2) Identifiers / business keys
  validates :name,
            presence: true,
            length: {
              maximum: 30
            },
            uniqueness: {
              scope: %i[catalog_id]
            }

  # 3) Domain fields
  validates :description, length: { maximum: 150 }

  # 4) State flags
  validates :visible, inclusion: { in: [ true, false ] }

  # 5) Domain temporal attributes
  # (none here)

  scope :populated, -> { joins(:product_categories).distinct }

  def self.ransackable_attributes(_auth_object = nil)
    %w[name description visible created_at updated_at]
  end
end
