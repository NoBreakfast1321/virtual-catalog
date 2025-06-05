# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  description :text(150)
#  name        :string(30)       not null
#  visible     :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :integer          not null
#
# Indexes
#
#  index_categories_on_business_id           (business_id)
#  index_categories_on_business_id_and_name  (business_id,name) UNIQUE
#
# Foreign Keys
#
#  business_id  (business_id => businesses.id) ON DELETE => cascade
#
class Category < ApplicationRecord
  include FilterableByVisibility
  include NameNormalizable

  belongs_to :business

  has_many :product_categories, dependent: :restrict_with_error
  has_many :products, through: :product_categories

  validates :visible, inclusion: { in: [ true, false ] }
  validates :name, length: { maximum: 30 }, presence: true, uniqueness: { scope: :business_id }
  validates :description, length: { maximum: 150 }, allow_blank: true

  def self.ransackable_attributes(auth_object = nil)
    %w[ visible name description created_at updated_at ]
  end
end
