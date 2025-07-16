# == Schema Information
#
# Table name: properties
#
#  id                :integer          not null, primary key
#  name              :string(50)       not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  property_group_id :integer          not null
#
# Indexes
#
#  index_properties_on_property_group_id           (property_group_id)
#  index_properties_on_property_group_id_and_name  (property_group_id,name) UNIQUE
#
# Foreign Keys
#
#  property_group_id  (property_group_id => property_groups.id) ON DELETE => cascade
#
class Property < ApplicationRecord
  audited

  include NameNormalizer

  belongs_to :property_group

  has_one :product, through: :property_group

  validates :name,
            length: {
              maximum: 50
            },
            presence: true,
            uniqueness: {
              scope: :property_group
            }
end
