class AddIndexesToActorAndFilm < ActiveRecord::Migration
  def change
    add_index :actors, :name
    add_index :films, :name
  end
end
