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
    def preorder(node = root)
        # Root Left Right
        return if node.nil?
    
        print "#{node.data} "
        preorder(node.left)
        preorder(node.right)
      end
    
      def inorder(node = root)
        # Left Root Right
        return if node.nil?
    
        inorder(node.left)
        print "#{node.data} "
        inorder(node.right)
      end
    
      def postorder(node = root)
        # Left Right Root
        return if node.nil?
    
        postorder(node.left)
        postorder(node.right)
        print "#{node.data} "
      end

      def height(node=root)
        if node.nil?
            return 0
        else
            left_height = height(node.left)
            right_height = height(node.right)
            return [left_height, right_height].max + 1
        end
    end

    def depth(node = root, parent = root, edges = 0)
        return 0 if node == parent
        return -1 if parent.nil?
    
        if node < parent.data
          edges += 1
          depth(node, parent.left, edges)
        elsif node > parent.data
          edges += 1
          depth(node, parent.right, edges)
        else
          edges
        end
      end

      def balanced?(node = root)
        return true if node.nil?
    
        left_height = height(node.left)
        right_height = height(node.right)
    
        return true if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)
    
        false
      end
    
      # balances an unbalanced tree
      def rebalance
        self.data = inorder_array
        self.root = build_tree(data)
      end
       # visualize binary search tree, method by student on Discord

      def pretty_print(node = root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
      end

      private

      # helper method that finds the leftmost leaf

      def leftmost_leaf(node)
        node = node.left until node.left.nil?

        node
      end

      # create inorder array of tree

      def inorder_array(node = root, array = [])
        unless node.nil?
          inorder_array(node.left, array)
          array << node.data
          inorder_array(node.right, array)
        end
        array
      end
    
    
    

end

# Create a binary search tree from an array of random numbers (Array.new(15) { rand(1..100) })

binary_tree = Tree.new((Array.new(15) { rand(1..100) }))

# Confirm that the tree is balanced by calling #balanced?
p binary_tree.balanced?


# Print out all elements in level, pre, post, and in order

p binary_tree.level_order
p binary_tree.preorder
p binary_tree.inorder
p binary_tree.postorder

# Unbalance the tree by adding several numbers > 100
10.times do
  a = rand(100...200)
  binary_tree.insert(a)
  puts "Inserted #{a} to tree."
end


# Confirm that the tree is unbalanced by calling #balanced?
p binary_tree.balanced?

# Balance the tree by calling #rebalance
binary_tree.rebalance

# Confirm that the tree is balanced by calling #balanced?

p binary_tree.balanced?

# Print out all elements in level, pre, post, and in order

p binary_tree.level_order
p binary_tree.preorder
p binary_tree.inorder
p binary_tree.postorder