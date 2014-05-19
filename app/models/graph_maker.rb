class GraphMaker
  attr_accessor :neo

  def initialize
    @neo = Neography::Rest.new  
  end

  def create_graph
    counter = 0
    max = Film.count
    
    Film.all.each do |film|
      film_node = find_or_create_node(film)
    
      film.actors.each do |actor|
        actor_node = find_or_create_node(actor)
        film_node.both(:friends) << actor_node
      end
    
      counter += 1
      puts "#{counter} of #{max}"
    end
  end

  def bacon_path(actor_name)
    actor_node = Neography::Node.find("actors", "name", actor_name)
    return nil if actor_node.nil?

    kevin_bacon = Neography::Node.find("actors", "name", "Kevin Bacon").first
    bacon_path = actor_node.first.shortest_path_to(kevin_bacon).incoming(:friends).depth(6).nodes
    
    return nil if bacon_path.nil?
    bacon_path.first.map do |node|
      Actor.find_by(name: node.name) || Film.find_by(name: node.name)
    end
  end

  def find_or_create_node(object)
    find_node(object) || create_node(object)
  end

  def create_node(object)
    node_params = {"name" => object.name, "image" => object.image}
    node = Neography::Node.create(node_params)
    node.add_to_index(object.table, "name", object.name)
    return node
  end
  
  def find_node(object)
    Neography::Node.find(object.table, "name", object.name).try(:first)
  end

  def to_partial_path
    "graph_maker"
  end
end
