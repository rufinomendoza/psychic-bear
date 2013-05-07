class AddNameAndCompanyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :company, :string
  end
end
