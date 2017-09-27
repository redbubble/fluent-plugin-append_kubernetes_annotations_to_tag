class KubernetesAnnotationsTagAppender
  attr_reader :annotations

  def initialize(annotations)
    @annotations = annotations
  end

  def append(tag, data)
    @annotations.reduce(tag) { |t, l| "#{t}.#{l}=#{data[l]}" }
  end
end
