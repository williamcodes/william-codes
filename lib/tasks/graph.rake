namespace :graph do
  desc "TODO"
  task seed: :environment do
    GraphMaker.new.create_graph
  end

end
