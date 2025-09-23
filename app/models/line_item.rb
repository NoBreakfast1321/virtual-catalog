# == Schema Information
#
# Table name: line_items
#
#  id          :integer          not null, primary key
#  quantity    :integer          default(1), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer
#  variant_id  :integer          not null
#
# Indexes
#
#  index_line_items_on_customer_id                 (customer_id)
#  index_line_items_on_customer_id_and_variant_id  (customer_id,variant_id) UNIQUE
#  index_line_items_on_variant_id                  (variant_id)
#  index_line_items_on_variant_id_and_customer_id  (variant_id,customer_id)
#
# Foreign Keys
#
#  customer_id  (customer_id => customers.id) ON DELETE => cascade
#  variant_id   (variant_id => variants.id) ON DELETE => cascade
#
class LineItem < ApplicationRecord
  # 1) Associations (FKs)
  belongs_to :variant
  belongs_to :customer, optional: true

  # 2) Identifiers / business keys
  validates :variant_id, uniqueness: { scope: %i[customer_id] }

  # 3) Domain fields
  validates :quantity,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1
            }

  # 4) State flags
  # (none here)

  # 5) Domain temporal attributes
  # (none here)
end
