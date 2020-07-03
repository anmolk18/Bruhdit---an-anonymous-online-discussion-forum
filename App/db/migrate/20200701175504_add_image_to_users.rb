class AddImageToUsers < ActiveRecord::Migration[6.0]
    def change
        add_column :users, :image, :string, :default => "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png"
     end
end