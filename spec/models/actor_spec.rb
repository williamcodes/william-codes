require 'spec_helper'

describe Actor do
  let(:blockbuster) { Film.create(name: "Blockbuster Hit") }
  let(:flop) { Film.create(name: "Terrible Flop") }
  
  let(:kevin) { Actor.create(name: "Kevin Bacon") }
  let(:kyra) { Actor.create(name: "Kyra Sedgwick") }
  let(:joaquin) { Actor.create(name: "Joaquin Phoenix") }
  
  context '#costars' do
    it "returns costars of an actor" do
      flop.actors << kevin
      flop.actors << kyra
      blockbuster.actors << kyra
      blockbuster.actors << joaquin
      
      expect(kevin.costars).to include(kyra)
      expect(kevin.costars).to_not include(joaquin)
    end
  end

  context '#bacon?' do
    it "returns true when actor is Kevin Bacon" do
      expect(kevin.bacon?).to eq true
    end

    it "returns false when actor is not Kevin Bacon" do
      expect(kyra.bacon?).to eq false
    end
  end
end
