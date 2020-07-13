class Company < ApplicationRecord
  has_rich_text :description

  validates :email, format: {
    with: /\b[A-Z0-9._%a-z\-]+@getmainstreet\.com\z/,
    message: "must be a getmainstreet.com domain" }

  before_save do
    zipcode_definition = ZipCodes.identify(self.zip_code)
    unless zipcode_definition.nil?
      self.city = zipcode_definition[:city]
      self.state = zipcode_definition[:state_name] + "/" + zipcode_definition[:state_code]
      # NOTE: I am storing both state codes and state names here so we can use it in any way we need.
    else
      errors.add(:zip_code, "Zipcode invalid")
      raise ActiveRecord::Rollback
    end
  end

end
