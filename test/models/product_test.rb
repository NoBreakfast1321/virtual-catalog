# == Schema Information
#
# Table name: products
#
#  id                  :integer          not null, primary key
#  available_from      :datetime
#  available_until     :datetime
#  code                :string(50)
#  description         :text(5000)
#  featured            :boolean          default(FALSE), not null
#  name                :string(150)      not null
#  price_cents         :integer          default(0), not null
#  price_currency      :string           default("USD"), not null
#  sale_ends_at        :datetime
#  sale_price_cents    :integer
#  sale_price_currency :string           default("USD")
#  sale_starts_at      :datetime
#  visible             :boolean          default(TRUE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer          not null
#
# Indexes
#
#  index_products_on_user_id           (user_id)
#  index_products_on_user_id_and_code  (user_id,code) UNIQUE WHERE code IS NOT NULL AND code <> ''
#  index_products_on_user_id_and_name  (user_id,name) UNIQUE
#
# Foreign Keys
#
#  user_id  (user_id => users.id) ON DELETE => cascade
#
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
