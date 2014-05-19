require 'spec_helper'

describe GraphMaker do
  let(:kevin_bacon) { Actor.find_by(name: "Kevin Bacon") }
  let(:brad_pitt) { Actor.find_by(name: "Brad Pitt") }

  context '#bacon_path' do
    it "finds the path to Kevin Bacon" do
      path = subject.bacon_path(brad_pitt)
      expect(path).to include(kevin_bacon)
      expect(path).to include(brad_pitt)
    end

    it "returns nil if it cannot find Kevin Bacon" do
      path = subject.bacon_path(Actor.new(name: "Fake Actor"))
      expect(path).to be_nil
    end
  end

  context '#create_node' do
    it "creates new nodes" do
      actor = Actor.new(name: "William", image:"william.codes")
      
      actor_node = subject.create_node(actor)
      expect(actor_node).to be_an_instance_of(Neography::Node)      
      
      actor_node.del
    end
  end

  context '#find_or_create_node' do
    it "creates nodes from actors" do
      actor = Actor.new(name: "William", image:"william.codes")
      actor_node = subject.find_or_create_node(actor)
      expect(actor_node).to be_an_instance_of(Neography::Node)
    end

    it "creates nodes from films" do
      film = Film.new(name: "Filmy Film", image: "filmyfilm.com")
      film_node = subject.find_or_create_node(film)
      expect(film_node).to be_an_instance_of(Neography::Node)
      film_node.del
    end

    it "does not create duplicate nodes" do
      film_node1 = subject.find_or_create_node(Film.first)
      film_node2 = subject.find_or_create_node(Film.first)
      expect(film_node1).to eq film_node2
    end
  end
end
