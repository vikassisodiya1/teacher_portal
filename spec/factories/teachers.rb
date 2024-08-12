# frozen_string_literal: true

FactoryBot.define do
  factory :teacher do
    qualification { "Bachelor's Degree" }
    experience { 5 }
    association :user
  end
end
