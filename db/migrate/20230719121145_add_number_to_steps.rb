class AddNumberToSteps < ActiveRecord::Migration[6.1]
  def change
    add_column :steps, :number, :integer
  end
end
