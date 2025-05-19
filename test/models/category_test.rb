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
require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @category = Category.new(
      visible: true,
      name: "Test Name",
      description: "Test Description",
      user: @user
    )
  end

  test "should be valid" do
    assert @category.valid?
  end

  test "should normalize name before validation" do
    @category.name = "  #{@category.name}  "
    @category.valid?
    assert_equal "#{@category.name}", @category.name
  end

  test "visible should be true or false" do
    @category.visible = true
    assert @category.valid?

    @category.visible = false
    assert @category.valid?

    @category.visible = nil
    assert_not @category.valid?
  end

  test "name should have a maximum length of 30 characters" do
    @category.name = "a" * 31
    assert_not @category.valid?
  end

  test "name should be present" do
    @category.name = nil
    assert_not @category.valid?
  end

  test "name should be unique per user" do
    category_clone = @category.dup
    @category.save
    assert_not category_clone.valid?
  end

  test "description should have a maximum length of 150 characters" do
    @category.description = "a" * 151
    assert_not @category.valid?
  end

  test "description can be nil" do
    @category.description = nil
    assert @category.valid?
  end
end
