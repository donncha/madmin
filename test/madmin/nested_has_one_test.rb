require "test_helper"

class NestedHasOneTest < ActiveSupport::TestCase
  test "checks for the right field class" do
    field = UserResource.attributes[:address].field

    # Make sure :address is a :nested_has_one type
    assert field.instance_of?(Madmin::Fields::NestedHasOne)
    assert_equal field.resource, AddressResource
  end

  test "skips fields which is skipped in configuration" do
    field = UserResource.attributes[:address].field

    # Make sure :zip is skipped in the AddressResource
    refute field.to_param.values.flatten.include?(:line2)
    assert field.to_param.values.flatten.include?(:line1)
  end

  test "whitelists unskipped and required params" do
    field = UserResource.attributes[:address].field
    expected_params = [:line1, :city, :state, :zip, "id"]
    assert expected_params.all? { |p| field.to_param[:address_attributes].include?(p) }
  end
end
