require 'spec_helper'

describe GraphMaker do
  context '#bacon_path' do
    it "finds the path to kevin bacon" do
      kevin_bacon = Actor.find_by(name: "Kevin Bacon")
      brad_pitt = Actor.find_by(name: "Brad Pitt")
      path = subject.bacon_path("Brad Pitt")
      expect(path).to include(kevin_bacon)
      expect(path).to include(brad_pitt)
    end
  end

  context '#proper_case' do
    it "proper cases a name" do
      actor_name = "kEvIn BaCoN"
      expect(subject.proper_case(actor_name)).to eq "Kevin Bacon"
    end
  end

  context '#find_or_create_node' do
    it "creates nodes from actors" do
      actor = Actor.first
      actor_node = subject.find_or_create_node(actor)
      expect(actor_node).to be_an_instance_of(Neography::Node)      
    end

    it "creates nodes from films" do
      film_node = subject.find_or_create_node(Film.first)
      expect(film_node).to be_an_instance_of(Neography::Node)      
    end

    it "does not create duplicate nodes" do
      film_node1 = subject.find_or_create_node(Film.first)
      film_node2 = subject.find_or_create_node(Film.first)
      expect(film_node1).to eq film_node2
    end
  end
end
