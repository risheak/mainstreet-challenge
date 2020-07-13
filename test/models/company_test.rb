require 'test_helper'

class CompanyTest < ActiveSupport::TestCase

  def setup
    @company = Company.new(name: "test", email: "abc@getmainstreet.com", zip_code: "12345")
  end

  test 'email validation for non getmainstreet domain' do
    @company.email = "abc@test.com"
    assert_raises ActiveRecord::RecordInvalid do
      @company.save!
    end
  end

  test 'email validation for getmainstreet domain' do
    assert(@company.save, true)
  end

  test 'persistence of city and state for a zipcode' do
    zipcode_definition = ZipCodes.identify(@company.zip_code)
    @company.save
    assert(@company.city, zipcode_definition[:city])
    assert(@company.state, zipcode_definition[:state_name] + "/" + zipcode_definition[:state_code])
  end
end
