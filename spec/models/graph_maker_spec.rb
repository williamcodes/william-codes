require 'spec_helper'

describe GraphMaker do
  let(:kevin_bacon) { Actor.find_by(name: "Kevin Bacon") }
  let(:brad_pitt) { Actor.find_by(name: "Brad Pitt") }

  context '#bacon_path' do
    it "finds the path to Kevin Bacon" do
      path = subject.bacon_path("Brad Pitt")
      expect(path).to include(kevin_bacon)
      expect(path).to include(brad_pitt)
    end

    it "returns nil if it cannot find Kevin Bacon" do
      path = subject.bacon_path("Fake Actor")
      expect(path).to be_nil
    end
  end

  context '#create_node' do
    it "creates new nodes" do
      actor = Actor.create(name: "William", image:"william.codes")
      actor_node = subject.create_node(actor)
      expect(actor_node).to be_an_instance_of(Neography::Node)      
    end
  end

  context '#find_or_create_node' do
    it "creates nodes from actors" do
      actor = Actor.create(name: "William", image:"william.codes")
      actor_node = subject.find_or_create_node(actor)
      expect(actor_node).to be_an_instance_of(Neography::Node)      
    end

    it "creates nodes from films" do
      film = Film.create(name: "Filmy Film", image: "filmyfilm.com")
      film_node = subject.find_or_create_node(film)
      expect(film_node).to be_an_instance_of(Neography::Node)      
    end

    it "does not create duplicate nodes" do
      film_node1 = subject.find_or_create_node(Film.first)
      film_node2 = subject.find_or_create_node(Film.first)
      expect(film_node1).to eq film_node2
    end
  end
end
