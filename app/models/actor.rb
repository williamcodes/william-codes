class Actor < ActiveRecord::Base
  has_many :actor_films
  has_many :films, through: :actor_films

  extend Graphable::ClassMethods
  neighbor :films
  searchkick autocomplete: ['name']

  def self.kevin_bacon
    find_by(name: "Kevin Bacon")
  end

  def text
    "with #{name}"
  end

end
