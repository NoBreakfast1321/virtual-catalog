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
