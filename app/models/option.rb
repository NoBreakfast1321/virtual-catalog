# == Schema Information
#
# Table name: options
#
#  id              :integer          not null, primary key
#  name            :string(50)       not null
#  price_cents     :integer          default(0), not null
#  price_currency  :string           default("USD"), not null
#  visible         :boolean          default(TRUE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  option_group_id :integer          not null
#
# Indexes
#
#  index_options_on_option_group_id           (option_group_id)
#  index_options_on_option_group_id_and_name  (option_group_id,name) UNIQUE
#
# Foreign Keys
#
#  option_group_id  (option_group_id => option_groups.id) ON DELETE => cascade
#
class Option < ApplicationRecord
  audited

  include NameNormalizer
  include VisibilityFilterer

  # 1) Associations (FKs)
  belongs_to :option_group

  # 2) Identifiers / business keys
  validates :name,
            presence: true,
            length: {
              maximum: 50
            },
            uniqueness: {
              scope: %i[option_group_id]
            }

  # 3) Domain fields
  monetize :price_cents

  validates :price_cents,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0
            }

  # 4) State flags
  validates :visible, inclusion: { in: [ true, false ] }

  # 5) Domain temporal attributes
  # (none here)
end
