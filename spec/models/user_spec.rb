require 'rails_helper'

RSpec.describe User, type: :model do
 describe 'Validations' do
   it "must be created with a password" do
     @user = User.new({first_name: "Dong",last_name: "Hu", email: "dong@dong.com", password: nil, password_confirmation: "password"})
     @user.save
     expect(@user.errors.full_messages).to include "Password can't be blank"
   end

   it "must be created with a password confirmation" do
    @user = User.new({first_name: "Dong", last_name: "Hu", email: "dong@dong.com", password: "password", password_confirmation: nil})
    @user.save
    expect(@user.errors.full_messages).to include "Password confirmation can't be blank"
   end

   it "must have matching password and password confirmation" do
     @user = User.new({first_name: "Dong",last_name: "Hu", email: "dong@dong.com", password: "password", password_confirmation: "differentpassword"})
     @user.save
     expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
   end

   it "must have password with a minimum length equal to 8" do
       @user = User.new({first_name: "Dong",last_name: "Hu", email: "dong@dong.com", password: "short", password_confirmation: "short"})
       @user.save
       expect(@user.errors.full_messages).to include "Password is too short (minimum is 8 characters)"
   end

   it "must have unique email" do
     @user1 = User.create({first_name: "Dong",last_name: "Hu", email: "dong@dong.com", password: "password", password_confirmation: "password"})
     @user2 = User.new({first_name: "Ariana",last_name: "Grande", email: "dong@dong.com", password: "password", password_confirmation: "password"})
     @user2.save
     expect(@user2.errors.full_messages).to include "Email has already been taken"
   end

   it "must have case insensitive email field" do
     @user1 = User.create({first_name: "Dong",last_name: "Hu", email: "dong@dong.com", password: "password", password_confirmation: "password"})
     @user2 = User.new({first_name: "Ariana",last_name: "Grande", email: "DONG@dong.com", password: "password", password_confirmation: "password"})
     @user2.save
     expect(@user2.errors.full_messages).to include "Email has already been taken"
   end
 end

   describe ".authenticate_with_credentials" do
    it "should return user when passed correct parameters" do
      @user = User.create({first_name: "Dong",last_name: "Hu", email: "dong@dong.com", password: "password", password_confirmation: "password"})
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eql @user
    end

    it "should return nil when passed incorrect email" do
      @user = User.create({first_name: "Dong",last_name: "Hu", email: "dong@dong.com", password: "password", password_confirmation: "password"})
      expect(User.authenticate_with_credentials("incorrect_email", @user.password)).to eql nil
    end

    it "should return nil when passed incorrect password" do
      @user = User.create({first_name: "Dong",last_name: "Hu", email: "dong@dong.com", password: "password", password_confirmation: "password"})
      expect(User.authenticate_with_credentials(@user.email, "incorrect_password")).to eql nil
    end

    it "should return user when email has spaces before or after" do
      @user = User.create({first_name: "Dong",last_name: "Hu", email: "dong@dong.com", password: "password", password_confirmation: "password"})
      expect(User.authenticate_with_credentials("    #{@user.email}", @user.password)).to eql @user
    end

    it "should return user when email has instances of uppercase characters" do
      @user = User.create({first_name: "Dong",last_name: "Hu", email: "dong@dong.com", password: "password", password_confirmation: "password"})
      expect(User.authenticate_with_credentials(@user.email.upcase, @user.password)).to eql @user
    end
  end
end
