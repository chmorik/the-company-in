class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :logo
      t.string :name
      t.string :company_type
      t.string :domain
      t.string :description
      t.string :industry
      t.integer :money_raised
      t.integer :market_cap
      t.integer :annual_revenue
      t.string :location
      t.integer :number_of_employees
      t.integer :likes
      t.string :clearbit_id
    end
  end
end
