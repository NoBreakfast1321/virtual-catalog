class Category < ApplicationRecord
  include FilterableByTimestamp
  include FilterableByVisibility
  include NameNormalizable
  include OrderableByTimestamp

  belongs_to :user

  validates :visible, inclusion: { in: [ true, false ] }
  validates :name, length: { maximum: 30 }, presence: true, uniqueness: { scope: :user_id }
  validates :description, length: { maximum: 150 }, allow_nil: true

  def self.ransackable_attributes(auth_object = nil)
    %w[ visible name description created_at updated_at ]
  end
end
