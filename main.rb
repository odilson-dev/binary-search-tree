# require 'queue'
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

    def delete(value, node = root)
        return node if node.nil?
    
        if value < node.data
          node.left = delete(value, node.left)
        elsif value > node.data
          node.right = delete(value, node.right)
        else
          # if node has one or no child
          return node.right if node.left.nil?
          return node.left if node.right.nil?
    
          # if node has two children
          leftmost_node = leftmost_leaf(node.right)
          node.data = leftmost_node.data
          node.right = delete(leftmost_node.data, node.right)
        end
        node
    end

    def find(value, node = root)
        return node if node.nil? or node.data == value 
        
        value < node.data ? find(value, node.left) : find(value, node.right)
        
    end
    # Binary tree - Level Order Traversal

    def level_order(node = root, queue = [])
        print "#{node.data} "
        queue << node.left unless node.left.nil?
        queue << node.right unless node.right.nil?
        return if queue.empty?
    
        level_order(queue.shift, queue)
    end




end


binary_tree = Tree.new([1, 2, 3, 4, 5])
binary_tree.level_order