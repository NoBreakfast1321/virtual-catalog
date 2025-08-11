# == Schema Information
#
# Table name: businesses
#
#  id          :integer          not null, primary key
#  description :text(150)
#  name        :string(30)       not null
#  slug        :string(30)       not null
#  visible     :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_businesses_on_slug              (slug) UNIQUE
#  index_businesses_on_user_id           (user_id)
#  index_businesses_on_user_id_and_name  (user_id,name) UNIQUE
#
# Foreign Keys
#
#  user_id  (user_id => users.id) ON DELETE => cascade
#
class Business < ApplicationRecord
  audited

  include NameNormalizer
  include SlugRestricter
  include VisibilityFilterer

  belongs_to :user

  has_many :categories, dependent: :destroy
  has_many :option_groups, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :property_groups, dependent: :destroy

  validates :description, length: { maximum: 150 }, allow_blank: true

  validates :name,
            length: {
              maximum: 30
            },
            presence: true,
            uniqueness: {
              scope: :user_id
            }

  validates :slug,
            format: {
              with: /\A[a-z0-9_-]+\z/
            },
            length: {
              maximum: 30
            },
            presence: true,
            uniqueness: true

  validates :visible, inclusion: { in: [ true, false ] }

  def self.ransackable_attributes(_auth_object = nil)
    %w[description name slug visible created_at updated_at]
  end
end
