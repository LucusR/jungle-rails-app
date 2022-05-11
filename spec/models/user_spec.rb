require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    
    it "Will save user if valid" do
      @user = User.new(
        name: "Test_Name",
        email: "test123@gmail.com",
        password: "test123",
        password_confirmation: "test123")

      @user.valid?
    end

    it "Confirms that password and Password Confirmation is the same" do
      @user = User.new(
        name: "Test_Name",
        email: "test123@gmail.com",
        password: "test123",
        password_confirmation: "test1234")

      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    
    it "Missing Name" do
      @user = User.new(
        email: "test123@gmail.com",
        password: "test123",
        password_confirmation: "test1234")

      @user.valid?
      expect(@user.errors[:name]).to include("can't be blank")
    end

    it "Missing Email" do
      @user = User.new(
        name: "Test_Name",
        password: "test123",
        password_confirmation: "test1234")

      @user.valid?
      expect(@user.errors[:email]).to include("can't be blank")
    end

    # it "Email is not unique" do
    #   @user1 = User.new(
    #     name: "Test_Name",
    #     email: "TEST123@gmail.com",
    #     password: "test123",
    #     password_confirmation: "test1234")
    #     @user1.save

    #     @user2 = User.new(
    #     name: "Test_Name1",
    #     email: "test123@gmail.com",
    #     password: "test123",
    #     password_confirmation: "test1234")

    #     @user2.valid?
    #     expect(@user2.errors[:email]).to include("has already been taken")
    # end

    it "The password must have a minimum length when a user account is being created." do
      @user = User.new(
        name: "Test_First_Name",
        password: "aaa",
        password_confirmation: "aaa")

      @user.valid?
      expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do

    it "Logs in if credentials are correct" do
      @user = User.new(
        name: "Test_Name",
        email: "test123456@gmail.com",
        password: "test123",
        password_confirmation: "test123")
        @user.save

        expect(User.authenticate_with_credentials("test123456@gmail.com", "test123")).to be_present
    end

    it "Does not log user in if email is incorrect" do
      @user = User.new(
        name: "Test_Name",
        email: "test123456@gmail.com",
        password: "test123",
        password_confirmation: "test123")
        @user.save

      expect(User.authenticate_with_credentials("test12345@gmail.com", "test123")).to be nil
    end

    it "Does not log user in if password is incorrect" do
      @user = User.new(
        name: "Test_Name",
        email: "test123456@gmail.com",
        password: "test123",
        password_confirmation: "test123")
        @user.save

      
      expect(User.authenticate_with_credentials("test123456@gmail.com", "test12")).to be false
    end

    it "Logs in user if email has spaces" do
    @user = User.new(
        name: "Test_Name",
        email: "test123456@gmail.com",
        password: "test123",
        password_confirmation: "test123")
        @user.save
      expect(User.authenticate_with_credentials("  test123456@gmail.com  ", "test123")).not_to be nil
    end

    it "Logs user in regardless of case-sensitivity" do
      @user = User.new(
        name: "Test_Name",
        email: "test123456@gmail.com",
        password: "test123",
        password_confirmation: "test123")
        @user.save

      expect(User.authenticate_with_credentials("TEST123456@gmail.com", "test123")).not_to be nil
    end
end
end