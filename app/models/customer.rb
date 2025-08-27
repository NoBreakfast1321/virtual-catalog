# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  email      :string
#  name       :string(150)
#  phone      :string(16)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  catalog_id :integer          not null
#  user_id    :integer
#
# Indexes
#
#  index_customers_on_catalog_id              (catalog_id)
#  index_customers_on_catalog_id_and_email    (catalog_id,email) UNIQUE
#  index_customers_on_catalog_id_and_phone    (catalog_id,phone) UNIQUE
#  index_customers_on_catalog_id_and_user_id  (catalog_id,user_id) UNIQUE
#  index_customers_on_user_id                 (user_id)
#
# Foreign Keys
#
#  catalog_id  (catalog_id => catalogs.id) ON DELETE => cascade
#  user_id     (user_id => users.id) ON DELETE => cascade
#
class Customer < ApplicationRecord
  audited

  include NameNormalizer

  # 1) Associations (FKs)
  belongs_to :catalog
  belongs_to :user, optional: true

  # 2) Identifiers / business keys
  validates :email,
            "valid_email_2/email": true,
            uniqueness: {
              scope: %i[catalog_id],
              case_sensitive: false
            },
            allow_blank: true

  validates :phone,
            phone: {
              possible: true,
              allow_blank: true
            },
            length: {
              maximum: 16
            },
            uniqueness: {
              scope: %i[catalog_id]
            },
            allow_blank: true

  # 3) Domain fields
  validates :name, length: { maximum: 150 }

  # 4) State flags
  # (none here)

  # 5) Domain temporal attributes
  # (none here)

  before_validation :normalize_email
  before_validation :normalize_phone

  def self.ransackable_attributes(_auth_object = nil)
    %w[email phone name created_at updated_at]
  end

  private

  def normalize_email
    self.email = email.to_s.downcase.strip.presence
  end

  def normalize_phone
    self.phone = Phonelib.parse(phone).sanitized.presence
  end
end
