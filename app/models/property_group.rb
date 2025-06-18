# == Schema Information
#
# Table name: property_groups
#
#  id         :integer          not null, primary key
#  name       :string(30)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :integer          not null
#
# Indexes
#
#  index_property_groups_on_product_id           (product_id)
#  index_property_groups_on_product_id_and_name  (product_id,name) UNIQUE
#
# Foreign Keys
#
#  product_id  (product_id => products.id) ON DELETE => cascade
#
class PropertyGroup < ApplicationRecord
  include NameNormalizer

  belongs_to :product

  has_many :properties, dependent: :destroy

  validates :name, length: { maximum: 30 }, presence: true, uniqueness: { scope: :product_id }
end
