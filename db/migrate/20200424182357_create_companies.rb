class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :zip_code
      t.string :phone
      t.string :email
    end
  end
end
