require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it "should let a user be created with full parameters" do
      user = User.create(
        first_name: "Charlie",
        last_name: "Oh",
        email: "js2oh@uwaterloo.ca",
        password: "a1s2d3f4g5",
        password_confirmation: "a1s2d3f4g5"
      )
      expect(user).to be_valid
      user.destroy
    end

    it "should not let a user be created without a first name" do
      user = User.create(
        first_name: "",
        last_name: "Oh",
        email: "js2oh@uwaterloo.ca",
        password: "a1s2d3f4g5",
        password_confirmation: "a1s2d3f4g5"
      )
      expect(user).not_to be_valid
    end

    it "should not let a user be created without a last name" do
      user = User.create(
        first_name: "Charlie",
        last_name: "",
        email: "js2oh@uwaterloo.ca",
        password: "a1s2d3f4g5",
        password_confirmation: "a1s2d3f4g5"
      )
      expect(user).not_to be_valid
    end

    it "should not let a user be created without an email" do
      user = User.create(
        first_name: "Charlie",
        last_name: "Oh",
        email: "",
        password: "a1s2d3f4g5",
        password_confirmation: "a1s2d3f4g5"
      )
      expect(user).not_to be_valid
    end

    it "should not let a user be created without a password" do
      user = User.create(
        first_name: "Charlie",
        last_name: "Oh",
        email: "js2oh@uwaterloo.ca",
        password: "",
        password_confirmation: "a1s2d3f4g5"
      )
      expect(user).not_to be_valid
    end

    it "should not let a user be created without a password confirmation" do
      user = User.create(
        first_name: "Charlie",
        last_name: "Oh",
        email: "js2oh@uwaterloo.ca",
        password: "a1s2d3f4g5",
        password_confirmation: ""
      )
      expect(user).not_to be_valid
    end

    it "should not let a user be created without making password and password_confirmation match" do
      user = User.create(
        first_name: "Charlie",
        last_name: "Oh",
        email: "js2oh@uwaterloo.ca",
        password: "a1s2d3f4g5",
        password_confirmation: "a1s2d3f4g"
      )
      expect(user).not_to be_valid
    end

    it "should not let a user be created without unique email" do
      unique_user = User.create(
        first_name: "Charlie",
        last_name: "Oh",
        email: "js2oh@uwaterloo.ca",
        password: "a1s2d3f4g5",
        password_confirmation: "a1s2d3f4g5"
      )
      user = User.create(
        first_name: "Polar",
        last_name: "Bear",
        email: "js2oh@uwaterloo.ca",
        password: "a1s2d3f4g5",
        password_confirmation: "a1s2d3f4g5"
      )
      expect(user).not_to be_valid
      unique_user.destroy
    end

    it "should not let a user be created without unique email (case-insensitive)" do
      unique_user = User.create(
        first_name: "Charlie",
        last_name: "Oh",
        email: "js2oh@uwaterloo.ca",
        password: "a1s2d3f4g5",
        password_confirmation: "a1s2d3f4g5"
      )
      user = User.create(
        first_name: "Polar",
        last_name: "Bear",
        email: "js2OH@uwaterloo.ca",
        password: "a1s2d3f4g5",
        password_confirmation: "a1s2d3f4g5"
      )
      expect(user).not_to be_valid
      unique_user.destroy
    end

    it "should not let a user be created without minimum password length (x < 8)" do
      user = User.create(
        first_name: "Polar",
        last_name: "Bear",
        email: "js2oh@uwaterloo.ca",
        password: "a1s2d3",
        password_confirmation: "a1s2d3"
      )
      expect(user).not_to be_valid
    end

    it "should not let a user be created without maximum password length (x > 20)" do
      user = User.create(
        first_name: "Polar",
        last_name: "Bear",
        email: "js2oh@uwaterloo.ca",
        password: "a1s2d3f4g5h6j7k8l9q0w",
        password_confirmation: "a1s2d3f4g5h6j7k8l9q0w"
      )
      expect(user).not_to be_valid
    end
  end

  describe '.authenticate_with_credentials' do

    correct_credentials = {
      email: "js2oh@uwaterloo.ca",
      password: "a1s2d3f4g5",
    }

    wrong_credentials = {
      email: "js@uwaterloo.ca",
      password: "a1s2d3f4",
    }

    EMAIL_WITH_WHITESPACES = "  js2oh@uwaterloo.ca   "
    CASE_INSENSITIVE_EMAIL = "Js2OH@uWATERloo.Ca"

    before(:all) do
      @user = User.create(
        first_name: "Charlie",
        last_name: "Oh",
        email: "js2oh@uwaterloo.ca",
        password: "a1s2d3f4g5",
        password_confirmation: "a1s2d3f4g5"
      )
    end

    after(:all) do
      @user.destroy
    end

    it "must return a matching user when authenticated with correct credentials" do
      user = User.authenticate_with_credentials(correct_credentials[:email], correct_credentials[:password])
      expect(user.email).to eq(@user.email)
      expect(user).to eq(@user)
    end

    it "must return nil when authenticated with wrong email" do
      user = User.authenticate_with_credentials(wrong_credentials[:email], correct_credentials[:password])
      expect(user).to eq(nil)
    end

    it "must return nil when authenticated with wrong password" do
      user = User.authenticate_with_credentials(correct_credentials[:email], wrong_credentials[:password])
      expect(user).to eq(nil)
    end

    it "must return a mathcing user with whitespaces around email" do
      user = User.authenticate_with_credentials(EMAIL_WITH_WHITESPACES, correct_credentials[:password])
      expect(user.email).to eq(@user.email)
      expect(user).to eq(@user)
    end

    it "must return a mathcing user with case insensitive email" do
      user = User.authenticate_with_credentials(CASE_INSENSITIVE_EMAIL, correct_credentials[:password])
      expect(user.email).to eq(@user.email)
      expect(user).to eq(@user)
    end
  end
end
