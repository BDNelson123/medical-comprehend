class CreateAzureQueries < ActiveRecord::Migration[5.2]
  def change
    create_table :azure_queries do |t|
      t.string :query_type
      t.text :text
      t.jsonb :result
      t.timestamps
    end
  end
end
