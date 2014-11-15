class AddSubmissionToLocations < ActiveRecord::Migration
  def change
    add_reference :locations, :submission, index: true
  end
end
