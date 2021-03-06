include ActionDispatch::TestProcess

FactoryBot.define do
  factory :lfs_object do
    sequence(:oid) { |n| "b68143e6463773b1b6c6fd009a76c32aeec041faff32ba2ed42fd7f708a%05x" % n }
    size 499013
  end

  trait :with_file do
    file { fixture_file_upload(Rails.root + "spec/fixtures/dk.png", "`/png") }
  end
end
