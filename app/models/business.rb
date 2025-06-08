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
#  index_businesses_on_slug     (slug) UNIQUE
#  index_businesses_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id) ON DELETE => cascade
#
class Business < ApplicationRecord
  include NameNormalizable

  belongs_to :user

  has_many :products, dependent: :destroy
  has_many :categories, dependent: :destroy

  validates :visible, inclusion: { in: [ true, false ] }
  validates :slug,
    format: {
      with: /\A[a-z0-9_-]+\z/,
      message: "can only contain lowercase letters, numbers, underscores and hyphens"
    },
    length: { maximum: 30 },
    presence: true,
    uniqueness: true

  validates :name, length: { maximum: 30 }, presence: true
  validates :description, length: { maximum: 150 }, allow_blank: true
end
