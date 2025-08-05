# == Schema Information
#
# Table name: product_property_groups
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  product_id        :integer          not null
#  property_group_id :integer          not null
#
# Indexes
#
#  idx_on_product_id_property_group_id_a2903aef74      (product_id,property_group_id) UNIQUE
#  idx_on_property_group_id_product_id_431a475453      (property_group_id,product_id)
#  index_product_property_groups_on_product_id         (product_id)
#  index_product_property_groups_on_property_group_id  (property_group_id)
#
# Foreign Keys
#
#  product_id         (product_id => products.id) ON DELETE => cascade
#  property_group_id  (property_group_id => property_groups.id) ON DELETE => restrict
#
class ProductPropertyGroup < ApplicationRecord
  belongs_to :product
  belongs_to :property_group

  validates :product, presence: true
  validates :property_group, presence: true

  validates :property_group_id, uniqueness: { scope: :product_id }
end
