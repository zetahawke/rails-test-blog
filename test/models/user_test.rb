require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should create a new user" do
  	u = User.new(username: "michel", email: "michel@gmail.com", password: "12345678")
  	assert u.save
  end

  test "should create a new user without an email" do
  	u = User.new(username: "michel", password: "12345678")
  	assert u.save
  end
end
