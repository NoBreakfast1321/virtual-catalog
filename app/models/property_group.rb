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

  belongs_to :business

  has_many :properties, dependent: :destroy

  validates :name,
            length: {
              maximum: 30
            },
            presence: true,
            uniqueness: {
              scope: :business_id
            }

  def self.ransackable_attributes(_auth_object = nil)
    %w[name created_at updated_at]
  end
end
