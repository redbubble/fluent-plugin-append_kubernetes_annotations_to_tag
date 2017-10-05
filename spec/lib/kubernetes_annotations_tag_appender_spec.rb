require 'kubernetes_annotations_tag_appender'

describe KubernetesAnnotationsTagAppender do
  describe '#append' do
    let (:annotations) { ['fluentd-s3', 'fluentd-sumo'] }

    context 'when all annotations match' do
      let (:container_name) { "appname" }
      it 'tags the record with all annotations' do
        data = {'fluentd-s3' => '["appname","nginx"]', 'fluentd-sumo' => '["appname"]'}
        expect(described_class.new(annotations).append('lol', data, container_name)).to eq('lol.annotated.fluentd-s3.fluentd-sumo')
      end

      it 'ignores irrelevant annotations' do
        data = {'fluentd-s3' => '["appname","nginx"]', 'fluentd-sumo' => '["appname"]', 'nope' => 'nope'}
        expect(described_class.new(annotations).append('lol', data, container_name)).to eq('lol.annotated.fluentd-s3.fluentd-sumo')
      end
    end

    context 'when not all annotations match' do
      let (:container_name) { "nginx" }
      it 'tags record with matching annotations ONLY' do
        data = {'fluentd-s3' => '["appname","nginx"]', 'fluentd-sumo' => '["appname"]'}
        expect(described_class.new(annotations).append('lol', data, container_name)).to eq('lol.annotated.fluentd-s3')
      end
      it 'leaves tag unchanged if none match' do
        data = {'fluentd-s3' => '["appname"]', 'fluentd-sumo' => '["appname"]'}
        expect(described_class.new(annotations).append('lol', data, container_name)).to eq('lol.annotated')
      end
      it 'defaults to appending no tags' do
        data = {}
        expect(described_class.new(annotations).append('lol', data, container_name)).to eq('lol.annotated')
      end
    end

    context 'tags are already present' do
      let (:container_name) { "appname" }
      it 'avoids duplicating tags' do
        data = {'fluentd-s3' => '["appname"]', 'fluentd-sumo' => '["appname"]'}
        expect(described_class.new(annotations).append('lol.fluentd-s3', data, container_name)).to eq('lol.fluentd-s3.annotated.fluentd-sumo')
      end
    end
  end
end
