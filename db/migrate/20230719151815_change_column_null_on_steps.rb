class ChangeColumnNullOnSteps < ActiveRecord::Migration[6.1]
  def change
    change_column_null :steps, :number, false
  end
end
