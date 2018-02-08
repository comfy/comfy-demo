# Renders image tag from http://picsum.photos
# Example: {{cms:lorem_picsum 400, 300}}
class LoremPicsum < ComfortableMexicanSofa::Content::Tag

  attr_reader :width, :height

  def initialize(context:, params: [], source: "")
    super
    @width  = params[0]
    @height = params[1]

    unless @width.present?
      raise Error, "Need at least one dimension of the image: #{source}"
    end
  end

  def content
    dimensions = [@width, @height].compact.join('/')
    "<img src='https://picsum.photos/#{dimensions}'/>"
  end
end

ComfortableMexicanSofa::Content::Renderer.register_tag(
  :lorem_picsum, LoremPicsum
)
