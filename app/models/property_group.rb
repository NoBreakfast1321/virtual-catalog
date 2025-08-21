# == Schema Information
#
# Table name: property_groups
#
#  id          :integer          not null, primary key
#  name        :string(30)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :integer          not null
#
# Indexes
#
#  index_property_groups_on_business_id           (business_id)
#  index_property_groups_on_business_id_and_name  (business_id,name) UNIQUE
#
# Foreign Keys
#
#  business_id  (business_id => businesses.id) ON DELETE => cascade
#
class PropertyGroup < ApplicationRecord
  audited

  include NameNormalizer

  # 1) Associations (FKs)
  belongs_to :business

  has_many :product_property_groups, dependent: :destroy
  has_many :products, through: :product_property_groups

  has_many :properties, dependent: :destroy

  # 2) Identifiers / business keys
  validates :name,
            presence: true,
            length: {
              maximum: 30
            },
            uniqueness: {
              scope: %i[business_id]
            }

  # 3) Domain fields
  # (none here)

  # 4) State flags
  # (none here)

  # 5) Domain temporal attributes
  # (none here)

  def self.ransackable_attributes(_auth_object = nil)
    %w[name created_at updated_at]
  end
end
