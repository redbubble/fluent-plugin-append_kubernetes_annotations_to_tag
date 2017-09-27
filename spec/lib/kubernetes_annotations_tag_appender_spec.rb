require 'kubernetes_annotations_tag_appender'

describe KubernetesAnnotationsTagAppender do
  describe '#append' do
    let (:annotations) { ['foo', 'baz'] }
    
    it 'appends the configured annotations to the tags with their names' do
      data = {'foo' => 'bar', 'baz' => 'qux'}

      expect(described_class.new(annotations).append('lol', data)).to eq('lol.foo=bar.baz=qux')
    end

    it 'only appends the configured annotations' do
      data = {'foo' => 'bar', 'baz' => 'qux', 'nope' => 'nope'}

      expect(described_class.new(annotations).append('lol', data)).to eq('lol.foo=bar.baz=qux')
    end

    it 'appends the configured annotations even if they are empty' do
      data = {}

      expect(described_class.new(annotations).append('lol', data)).to eq('lol.foo=.baz=')
    end
  end
end
