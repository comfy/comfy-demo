class CreateScaffoldModels < ActiveRecord::Migration

  def change
    create_table :scaffold_models do |t|
      t.string :name
      t.timestamps
    end
  end

end