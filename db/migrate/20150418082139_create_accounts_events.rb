class CreateAccountsEvents < ActiveRecord::Migration
  def change
    create_table :accounts_events do |t|
      t.references :account
      t.references :event
    end
    add_index :accounts_events, [:account_id, :event_id]
    add_index :accounts_events, :event_id
  end
end
