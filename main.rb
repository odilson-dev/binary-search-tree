class Node
    include Comparable
    attr_reader :data
    def initialize(data)
        @data = data
        @left = nil
        @right = nil
    end

    def <=>(other_nodes)
        @data <=> other_nodes.data
    end
end