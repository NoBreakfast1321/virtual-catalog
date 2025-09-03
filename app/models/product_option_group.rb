# == Schema Information
#
# Table name: product_option_groups
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  option_group_id :integer          not null
#  product_id      :integer          not null
#
# Indexes
#
#  index_product_option_groups_on_option_group_id                 (option_group_id)
#  index_product_option_groups_on_option_group_id_and_product_id  (option_group_id,product_id)
#  index_product_option_groups_on_product_id                      (product_id)
#  index_product_option_groups_on_product_id_and_option_group_id  (product_id,option_group_id) UNIQUE
#
# Foreign Keys
#
#  option_group_id  (option_group_id => option_groups.id) ON DELETE => restrict
#  product_id       (product_id => products.id) ON DELETE => cascade
#
class ProductOptionGroup < ApplicationRecord
  # 1) Associations (FKs)
  belongs_to :product
  belongs_to :option_group

  # 2) Identifiers / business keys
  validates :option_group_id, uniqueness: { scope: %i[product_id] }

  # 3) Domain fields
  # (none here)

  # 4) State flags
  # (none here)

  # 5) Domain temporal attributes
  # (none here)
end
