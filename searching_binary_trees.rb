class Node
  attr_accessor :value, :parent, :left_child, :right_child

  def initialize(value, parent=nil, left_child=nil, right_child=nil)
    @value = value
    @parent = parent
    @left_child = left_child
    @right_child = right_child
  end
end

class Tree
  attr_reader :root

  def initialize(values, root=nil)
    @root = root
    @values = values
    @nodes = build_nodes(@values)
    @init_tree = build_tree(@nodes)
  end

  def build_nodes(nodes)
    output = []
    nodes.shuffle.each { |value| output << Node.new(value) }
    output
  end

  def build_tree(nodes)
    @root = nodes.shift
    until nodes.empty? do
      add_node(nodes.shift)
    end
  end

  def add_node(node)
    current = @root
    node_placed = false
    until node_placed
      if node.value < current.value
        if current.left_child
          current = current.left_child
        else
          current.left_child = node
          node.parent = current
          node_placed = true
        end
      else
        if current.right_child
          current = current.right_child
        else
          current.right_child = node
          node.parent = current
          node_placed = true
        end
      end
    end
  end

  def breadth_first_search(target)
    queue = [@root]
    until queue.empty?
      node = queue.shift
      return node if node.value == target
      queue << node.left_child unless node.left_child.nil?
      queue << node.right_child unless node.right_child.nil?
    end
  end

  def depth_first_search(target)
    stack = [@root]
    until stack.empty?
      node = stack.pop
      return node if node.value == target
      stack << node.left_child unless node.left_child.nil?
      stack << node.right_child unless node.right_child.nil?
    end
  end
end