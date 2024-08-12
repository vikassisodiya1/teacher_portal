# frozen_string_literal: true

FactoryBot.define do
  factory :mark do
    score { 85 }
    association :student
    association :subject
  end
end
