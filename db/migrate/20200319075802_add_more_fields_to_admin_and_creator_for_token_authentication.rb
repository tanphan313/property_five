class AddMoreFieldsToAdminAndCreatorForTokenAuthentication < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :provider, :string, null: false, default: "email"
    add_column :admins, :uid, :string, null: false, default: ""
    add_column :admins, :tokens, :json

    add_column :creators, :provider, :string, null: false, default: "email"
    add_column :creators, :uid, :string, null: false, default: ""
    add_column :creators, :tokens, :json
  end
end
