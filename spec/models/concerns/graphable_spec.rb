require 'spec_helper'

describe Graphable do

  context '#neighbors' do
    let(:blockbuster) { Film.create(name: "Blockbuster Hit") }
    let(:flop) { Film.create(name: "Terrible Flop") }
    
    let(:kevin) { Actor.create(name: "Kevin Bacon") }
    let(:kyra) { Actor.create(name: "Kyra Sedgwick") }
    let(:joaquin) { Actor.create(name: "Joaquin Phoenix") }
  
    it "returns neighbors of a node" do
      flop.actors << kevin
      flop.actors << kyra
      blockbuster.actors << kyra
      blockbuster.actors << joaquin
      
      expect(joaquin.neighbors).to include(blockbuster)
      expect(blockbuster.neighbors).to_not include(kevin)
    end
  end
end