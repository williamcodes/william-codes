class GraphMaker
  attr_accessor :neo

  def initialize
    @neo = Neography::Rest.new  
  end

  def kevin_bacon_node
    find_node(Actor.kevin_bacon)
  end

  def bacon_path(actor)
    actor_node = find_node(actor)
    return nil if actor_node.nil?

    bacon_path = actor_node.shortest_path_to(kevin_bacon_node).
                 incoming(:friends).depth(6).nodes.first
    
    return nil if bacon_path.nil?
      
    bacon_path.map do |node|
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
    Neography::Node.find(object.table, "name", object.name)
  end

  def to_partial_path
    "graph_maker"
  end
end
