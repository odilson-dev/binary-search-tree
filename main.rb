class Node
    include Comparable
    attr_accessor :data, :left, :right
    def initialize(data=0, left=nil, right=nil)
        @data = data
        @left = left
        @right = right
    end

    def <=>(other_nodes)
        @data <=> other_nodes.data
    end
end

class Tree
    def initialize(arr)
        @arr = arr
        @root = build_tree(@arr, 0, @arr.length - 1)
    end

    def build_tree(an_array, start_tree, end_tree)
        if start_tree > end_tree
            return nil
        end

        mid_tree = (start_tree + end_tree) / 2

        root = Node.new(an_array[mid_tree])

        root.left = build_tree(an_array, start_tree, mid_tree - 1)
        root.right = build_tree(an_array, mid_tree + 1, end_tree)

        return root
    end
end

