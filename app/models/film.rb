class Film < ActiveRecord::Base
  has_many :actor_films
  has_many :actors, through: :actor_films

  extend Graphable::ClassMethods
  neighbor :actors

  def text
    "who was in #{name}"
  end
end
