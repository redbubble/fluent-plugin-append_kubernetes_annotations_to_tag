require 'fluent/output'

module Fluent
  class Fluent::AppendKubernetesAnnotationsToTag < Fluent::Output
    Fluent::Plugin.register_output('append_kubernetes_annotations_to_tag', self)

    config_param :annotations, :string

    def configure(conf)
      super

      @annotations = conf['annotations'].split(',')
    end

    def emit(tag, es, chain)
      es.each do |time, record|
        events(tag, time, record).each do |(tag, time, record)|
          router.emit(tag, time, record)
        end
      end

      chain.next

    rescue
      log.error "Failed to re-format docker record #{record}"
      # this seems to be a way to safely swallow records we don't know how to format
      ""
    end

    private

    def events(tag, time, record)
      [
        event(tag, time, record)
      ]
    end

    def event(tag, time, record)
      new_tag = if record.has_key? 'kubernetes' && record['kubernetes'].has_key? 'annotations'
        kubernetes_annotations_tag_appender.append(tag, record['kubernetes']['annotations'])
      else
        tag
      end

      [
        new_tag,
        time,
        record
      ]
    end

    def kubernetes_annotations_tag_appender
      @kubernetes_annotations_tag_appender ||= KubernetesAnnotationsTagAppender.new(@annotations)
    end
  end
end
