namespace :graph do
  
  task delete: :environment do
    gm = GraphMaker.new
    counter = 0
    max = Film.count
    
    Film.all.each do |film|
      film_node = gm.find_or_create_node(film)
      film_node.del

      film.actors.each do |actor|
        actor_node = gm.find_or_create_node(actor)
        actor_node.del
      end
    
      counter += 1
      puts "#{counter} of #{max}"
    end
  end

  task seed: :environment do
    gm = GraphMaker.new
    counter = 0
    max = Film.count
    
    Film.all.each do |film|
      film_node = gm.find_or_create_node(film)
    
      film.actors.each do |actor|
        actor_node = gm.find_or_create_node(actor)
        film_node.both(:friends) << actor_node
      end
    
      counter += 1
      puts "#{counter} of #{max}"
    end
  end
end
