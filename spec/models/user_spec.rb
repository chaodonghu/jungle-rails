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
end
