require 'fluent/output'
require 'kubernetes_annotations_tag_appender'

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
        new_tag = process_tag(tag, record)
        next if new_tag == tag

        router.emit(new_tag, time, record)
      end

      chain.next
    rescue => exception
      log.error "Failed to re-format docker record #{tag}"
      log.error exception
      log.error exception.backtrace

      # this seems to be a way to safely swallow records we don't know how to format
      ""
    end

    private

    def process_tag(tag, record)
      if record.has_key?('kubernetes') && record['kubernetes'].has_key?('annotations')
        kubernetes_annotations_tag_appender.append(tag,
                                                   record['kubernetes']['annotations'],
                                                   record['kubernetes']['container_name'])
      else
        tag
      end
    end

    def kubernetes_annotations_tag_appender
      @kubernetes_annotations_tag_appender ||= KubernetesAnnotationsTagAppender.new(@annotations)
    end
  end
end
