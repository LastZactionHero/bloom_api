FactoryGirl.define do
  factory :bed_template do
    config { File.read("#{Rails.root}/spec/fixtures/bed_template_a.json") }
  end
end
