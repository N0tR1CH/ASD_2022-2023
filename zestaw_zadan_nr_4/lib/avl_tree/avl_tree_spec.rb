require_relative 'avl_tree'

describe AVLTree::Node do
  describe '#insert_node' do
    let(:first_value) { 'some_kind_of_value' }
    let(:second_value) { 'better_kind_of_value' }
    let(:third_value) { 'the_best_kind_of_value' }
    let(:tree) { AVLTree.new }

    context 'when the tree is empty' do
      it 'inserts the node as the root' do
        tree.insert(10, first_value)

        expect(tree.root.key).to eq(10)
        expect(tree.root.value).to eq(first_value)
      end
    end

    context 'when the tree is not empty' do
      it 'does Left Left rotation well' do
        tree.insert(10, first_value)
        tree.insert(20, second_value)
        tree.insert(30, third_value)

        expect(tree.root.key).to eq(20)
        expect(tree.root.left.key).to eq(10)
        expect(tree.root.right.key).to eq(30)
      end

      it 'does Right Right rotation well' do
        tree.insert(30, first_value)
        tree.insert(20, second_value)
        tree.insert(10, third_value)

        expect(tree.root.key).to eq(20)
        expect(tree.root.left.key).to eq(10)
        expect(tree.root.right.key).to eq(30)
      end

      it 'does Left Right rotation well' do
        tree.insert(30, first_value)
        tree.insert(10, second_value)
        tree.insert(20, third_value)

        expect(tree.root.key).to eq(20)
        expect(tree.root.left.key).to eq(10)
        expect(tree.root.right.key).to eq(30)
      end

      it 'does Right Left rotation well' do
        tree.insert(20, first_value)
        tree.insert(30, second_value)
        tree.insert(10, third_value)

        expect(tree.root.key).to eq(20)
        expect(tree.root.left.key).to eq(10)
        expect(tree.root.right.key).to eq(30)
      end
    end
  end
end
