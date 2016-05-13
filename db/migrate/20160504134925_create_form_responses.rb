class CreateFormResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :form_responses do |t|
      t.integer :year
      t.string :disability
      t.string :sex
      t.string :income
      t.string :carer
      t.string :gp_visits
      t.boolean :hospital_time
      t.string :problem_type
      t.string :referral_type
      t.boolean :telephone_usage
      t.integer :feedback

      t.timestamps
    end
  end
end
