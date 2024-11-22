# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { 'testuser@example.com' }
    gender { 'male' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.now }
  end
end
