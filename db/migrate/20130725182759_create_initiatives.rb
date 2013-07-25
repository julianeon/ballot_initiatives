class CreateInitiatives < ActiveRecord::Migration
  def change
    create_table :initiatives do |t|
      t.datetime :election_date
      t.string :prop_letter
      t.string :title
      t.text :description
      t.boolean :pass_fail
      t.integer :yes_count
      t.integer :no_count
      t.string :percent_required
      t.string :measure_type
      t.string :initiator
      t.string :scan_url

      t.timestamps
    end
  end
end
