class ActorFilms < ActiveRecord::Migration
  def change
    create_table :actor_films, :id => false do |t|
      t.references :actor, :null => false
      t.references :film, :null => false
    end
  end
end
