class Category < ApplicationRecord
  belongs_to :user

  before_validation :normalize_name

  validates :visible, inclusion: { in: [ true, false ] }
  validates :name, length: { maximum: 30 }, presence: true, uniqueness: { scope: :user_id }
  validates :description, length: { maximum: 150 }, allow_nil: true

  scope :visible, -> { where(visible: true) }
  scope :invisible, -> { where(visible: false) }

  private

  def normalize_name
    self.name = name.strip if name.present?
  end
end
