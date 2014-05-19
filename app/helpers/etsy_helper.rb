module EtsyHelper
  module InstanceMethods
    def cast_of_frost_nixon
      Film.find(1961).actors
    end

    def proper_case(name)
      name.split(" ").map(&:capitalize).join(" ")
    end
  end
end