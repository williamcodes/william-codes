require 'spec_helper'

describe BaconFinder do
  let!(:joaquin) { Actor.create(name: "Joaquin Phoenix") }
  let!(:kyra) { Actor.create(name: "Kyra Sedgwick") }
  let!(:kevin) { Actor.create(name: "Kevin Bacon") }
  let!(:blockbuster) { Film.create(name: "Blockbuster Hit") }
  let!(:flop) { Film.create(name: "Terrible Flop") }
  let!(:bacon_finder) { BaconFinder.new(joaquin) }

  context '#find_bacon' do
    it "returns true when it finds kevin bacon" do
      blockbuster.actors << joaquin
      blockbuster.actors << kyra
      flop.actors << kyra
      flop.actors << kevin
    
      expect(bacon_finder.find_bacon).to eq true
    end

    it "creates a traveled path" do
      blockbuster.actors << joaquin
      blockbuster.actors << kyra
      flop.actors << kyra
      flop.actors << kevin
      bacon_finder.find_bacon

      expect(bacon_finder.traveled_path).to be_an_instance_of(Array)
    end

    it "returns false if it cannot find kevin bacon" do
      blockbuster.actors << joaquin
      blockbuster.actors << kyra
      flop.actors << kyra
    
      expect(bacon_finder.find_bacon).to eq false
    end
  end

  context '#short_path' do
    it "returns the shortest path a bacon_finder can find" do
      blockbuster.actors << joaquin
      blockbuster.actors << kyra
      flop.actors << kyra
      flop.actors << kevin

      bacon_finder.find_bacon
      shortest_path = [joaquin, blockbuster, kyra, flop, kevin]
      expect(bacon_finder.short_path).to eq shortest_path
    end
  end

  context '#pretty_path' do
    it "returns a pretty version of the shortest path" do
      blockbuster.actors << joaquin
      blockbuster.actors << kyra
      flop.actors << kyra
      flop.actors << kevin

      bacon_finder.find_bacon
      expect(bacon_finder.pretty_path).to include joaquin.name
    end
  end
end