# == Schema Information
#
# Table name: option_groups
#
#  id                 :integer          not null, primary key
#  maximum_selections :integer
#  minimum_selections :integer          default(1), not null
#  name               :string(30)       not null
#  visible            :boolean          default(TRUE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  catalog_id         :integer          not null
#
# Indexes
#
#  index_option_groups_on_catalog_id           (catalog_id)
#  index_option_groups_on_catalog_id_and_name  (catalog_id,name) UNIQUE
#
# Foreign Keys
#
#  catalog_id  (catalog_id => catalogs.id) ON DELETE => cascade
#
class OptionGroup < ApplicationRecord
  audited

  include NameNormalizer
  include VisibilityFilterer

  # 1) Associations (FKs)
  belongs_to :catalog

  has_many :options, dependent: :destroy

  has_many :product_option_groups, dependent: :destroy
  has_many :products, through: :product_option_groups

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
  validates :minimum_selections,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1
            }

  validates :maximum_selections,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: :minimum_selections
            },
            if: -> do
              minimum_selections.present? && maximum_selections.present?
            end

  # 4) State flags
  validates :visible, inclusion: { in: [ true, false ] }

  # 5) Domain temporal attributes
  # (none here)

  def self.ransackable_attributes(_auth_object = nil)
    %w[name minimum_selections maximum_selections visible created_at updated_at]
  end
end
