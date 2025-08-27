# == Schema Information
#
# Table name: catalogs
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
#  index_catalogs_on_slug              (slug) UNIQUE
#  index_catalogs_on_user_id           (user_id)
#  index_catalogs_on_user_id_and_name  (user_id,name) UNIQUE
#
# Foreign Keys
#
#  user_id  (user_id => users.id) ON DELETE => cascade
#
class Catalog < ApplicationRecord
  audited

  include NameNormalizer
  include SlugRestricter
  include VisibilityFilterer

  # 1) Associations (FKs)
  belongs_to :user

  has_many :categories, dependent: :destroy
  has_many :customers, dependent: :destroy
  has_many :option_groups, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :property_groups, dependent: :destroy

  # 2) Identifiers / business keys
  validates :name,
            presence: true,
            length: {
              maximum: 30
            },
            uniqueness: {
              scope: %i[user_id]
            }

  validates :slug,
            presence: true,
            length: {
              maximum: 30
            },
            format: {
              with: /\A[a-z0-9_-]+\z/
            },
            uniqueness: true

  # 3) Domain fields
  validates :description, length: { maximum: 150 }

  # 4) State flags
  validates :visible, inclusion: { in: [ true, false ] }

  # 5) Domain temporal attributes
  # (none here)

  def self.ransackable_attributes(_auth_object = nil)
    %w[name slug description visible created_at updated_at]
  end
end
