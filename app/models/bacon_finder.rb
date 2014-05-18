class BaconFinder
  attr_accessor :actor, :traveled_path, :visited_nodes, :node_queue, :current_node, :solution_path

  def initialize(actor)
    @actor = actor
    @traveled_path = []
    @visited_nodes = {}
    @node_queue = []
  end

  def find_bacon
    self.node_queue << self.actor

    until node_queue.empty?
      current_node = node_queue.shift
      traveled_path << current_node
      return true if current_node.bacon?

      node_neighbors = current_node.neighbors
      node_neighbors.each do |neighbor|
        self.node_queue << neighbor unless visited_nodes[neighbor.name]
        visited_nodes[current_node.name] = true
      end
    end

    return false
  end

  def short_path
    backtrace = [traveled_path.last]

    traveled_path.reverse_each do |this_node|
      last_node = backtrace.first
      backtrace.unshift(this_node) if last_node.neighbors?(this_node)
    end

    return backtrace
  end

  def pretty_path
    short_path.map(&:name).join(" => ")
  end

  def to_partial_path
    "bacon_finder"
  end
end