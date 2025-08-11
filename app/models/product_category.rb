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
  belongs_to :product
  belongs_to :category

  validates :product, presence: true
  validates :category, presence: true

  validates :category_id, uniqueness: { scope: :product_id }
end
