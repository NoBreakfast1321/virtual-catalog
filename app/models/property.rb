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

  # 1) Associations (FKs)
  belongs_to :property_group

  has_many :variant_properties, dependent: :destroy
  has_many :variants, through: :variant_properties

  # 2) Identifiers / business keys
  validates :name,
            presence: true,
            length: {
              maximum: 50
            },
            uniqueness: {
              scope: %i[property_group_id]
            }

  # 3) Domain fields
  # (none here)

  # 4) State flags
  # (none here)

  # 5) Domain temporal attributes
  # (none here)
end
