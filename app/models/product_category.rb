# == Schema Information
#
# Table name: product_categories
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  product_id  :integer          not null
#
# Indexes
#
#  index_product_categories_on_category_id                 (category_id)
#  index_product_categories_on_category_id_and_product_id  (category_id,product_id)
#  index_product_categories_on_product_id                  (product_id)
#  index_product_categories_on_product_id_and_category_id  (product_id,category_id) UNIQUE
#
# Foreign Keys
#
#  category_id  (category_id => categories.id) ON DELETE => restrict
#  product_id   (product_id => products.id) ON DELETE => cascade
#
class ProductCategory < ApplicationRecord
  # 1) Associations (FKs)
  belongs_to :product
  belongs_to :category

  # 2) Identifiers / business keys
  validates :category_id, uniqueness: { scope: %i[product_id] }

  # 3) Domain fields
  # (none here)

  # 4) State flags
  # (none here)

  # 5) Domain temporal attributes
  # (none here)
end
