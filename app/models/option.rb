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

  belongs_to :option_group

  monetize :price_cents

  validates :name,
            length: {
              maximum: 50
            },
            presence: true,
            uniqueness: {
              scope: :option_group
            }

  validates :price_cents,
            numericality: {
              greater_than_or_equal_to: 0
            },
            presence: true

  validates :visible, inclusion: { in: [ true, false ] }
end
