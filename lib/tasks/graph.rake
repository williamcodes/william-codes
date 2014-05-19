namespace :graph do
  desc "TODO"
  task seed: :environment do
    GraphMaker.new.create_graph
  end

  task delete: :environment do
    GraphMaker.new.delete_graph
  end

end
