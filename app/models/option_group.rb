# == Schema Information
#
# Table name: option_groups
#
#  id                 :integer          not null, primary key
#  maximum_selections :integer
#  minimum_selections :integer          default(1), not null
#  name               :string(30)       not null
#  visible            :boolean          default(TRUE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  business_id        :integer          not null
#
# Indexes
#
#  index_option_groups_on_business_id           (business_id)
#  index_option_groups_on_business_id_and_name  (business_id,name) UNIQUE
#
# Foreign Keys
#
#  business_id  (business_id => businesses.id) ON DELETE => cascade
#
class OptionGroup < ApplicationRecord
  audited

  include NameNormalizer
  include VisibilityFilterer

  belongs_to :business

  has_many :options, dependent: :destroy

  has_many :product_option_groups, dependent: :destroy
  has_many :products, through: :product_option_groups

  validates :maximum_selections,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: :minimum_selections
            },
            allow_nil: true

  validates :minimum_selections,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1
            }

  validates :name,
            length: {
              maximum: 30
            },
            presence: true,
            uniqueness: {
              scope: :business_id
            }

  validates :visible, inclusion: { in: [ true, false ] }

  def self.ransackable_attributes(_auth_object = nil)
    %w[maximum_selections minimum_selections name visible created_at updated_at]
  end
end
