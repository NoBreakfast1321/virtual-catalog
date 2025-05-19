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
#  user_id     :integer          not null
#
# Indexes
#
#  index_categories_on_user_id           (user_id)
#  index_categories_on_user_id_and_name  (user_id,name) UNIQUE
#
# Foreign Keys
#
#  user_id  (user_id => users.id) ON DELETE => cascade
#
class Category < ApplicationRecord
  include FilterableByTimestamp
  include FilterableByVisibility
  include NameNormalizable
  include OrderableByTimestamp

  belongs_to :user

  has_many :product_categories, dependent: :restrict_with_error
  has_many :products, through: :product_categories

  before_destroy :ensure_no_orphans

  validates :visible, inclusion: { in: [ true, false ] }
  validates :name, length: { maximum: 30 }, presence: true, uniqueness: { scope: :user_id }
  validates :description, length: { maximum: 150 }, allow_nil: true

  def self.ransackable_attributes(auth_object = nil)
    %w[ visible name description created_at updated_at ]
  end

  private

  def ensure_no_orphans
    orphaned = products.select { |p| p.categories.count <= 1 }

    if orphaned.any?
      throw :abort
    end
  end
end
