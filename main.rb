class Node
    include Comparable
    attr_accessor :data, :left, :right
    def initialize(data)
        @data = data
        @left = nil
        @right = nil
    end

    def <=>(other_nodes)
        @data <=> other_nodes.data
    end

end

class Tree
    attr_accessor :root, :data
    def initialize(array)
        @data= array.uniq.sort
        @root = build_tree(@data)
    end

    def build_tree(an_array)
        return nil if an_array.empty?

        mid_tree =  (an_array.length - 1) / 2

        root = Node.new(an_array[mid_tree])

        root.left = build_tree(an_array[0...mid_tree])
        root.right = build_tree(an_array[mid_tree + 1..-1])

        return root
    end

    def insert(value, root=self.root)
        
        return Node.new(value) if root.nil?
        
        if root.data == value
            return root.data
        elsif root.data < value
            root.right.nil? ? root.right = Node.new(value) : insert(value, root.right)
        else
            root.left.nil? ? root.left = Node.new(value) : insert(value, root.left)
        end
    end
end


binary_tree = Tree.new([1, 2, 3, 4, 5])
binary_tree.insert(6)

p binary_tree.root