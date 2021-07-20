class AddEvaluationToMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :evaluation, :float
  end
end
