class AddEditorToProducts < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :editor, polymorphic: true, index: true
  end
end
