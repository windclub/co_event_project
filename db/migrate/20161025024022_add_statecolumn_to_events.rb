class AddStatecolumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :state, :string
  end
end
