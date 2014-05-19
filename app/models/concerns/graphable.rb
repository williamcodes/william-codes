module Graphable
  module ClassMethods
    def neighbor(relation)
      alias_method :neighbors, relation
  
      define_method :neighbors? do |neighbor|
        send(relation.to_s).include?(neighbor)
      end

      define_method :bacon? do 
        name == "Kevin Bacon"
      end

      define_method :table do 
        "#{self.class.to_s.downcase}s"
      end

      define_method :neighbor_table do
        relation
      end
    end
  end
end