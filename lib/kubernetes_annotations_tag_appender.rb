require 'json'

class KubernetesAnnotationsTagAppender
  attr_reader :annotations

  def initialize(annotations)
    @annotations = annotations
  end

  def append(tag, data, container_name)
    matches = annotations.select do | annotation |
      json = data[annotation] || "[]"
      JSON.parse(json)&.include? container_name
    end

    # Don't re-add tags if they're already present:
    orig_tags = tag.split(".")

    # Unique with order preservation:
    uniqs = orig_tags + ["annotated"] + matches.reject { |x| orig_tags.include? x }
    return uniqs.join(".")
  end
end
