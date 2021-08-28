# frozen_string_literal: true

module TagCreator
  def self.render(tag_object)
    return '' if tag_object.nil?
    if tag_object.is_a?(::String) || tag_object.is_a?(::Integer)
      return tag_object
    end

    str = "<#{tag_object.tag_name}>"
    str += TagCreator.render(tag_object.content)
    str += "</#{tag_object.tag_name}>"
    str
  end
end

class Tag
  attr_reader :tag_name, :content
  def initialize(tag_name, content)
    @tag_name = tag_name
    @content = content
  end
end

class DivTag
  attr_reader :content
  def initialize(content)
    @content = content
  end
end

class DivTagAdapter
  attr_reader :div_tag
  def initialize(div_tag)
    @div_tag = div_tag
  end

  def tag_name
    'div'
  end

  def content
    div_tag.content
  end
end

p_tag = Tag.new('p', 'it is just paragraph')
puts TagCreator.render(p_tag)
# <p>it is just paragraph</p>

p_tag2 = Tag.new(
  'div',
  Tag.new('small', 'it is small text')
)
puts TagCreator.render(p_tag2)
# <div><small>it is small text</small></div>

div_tag = DivTag.new('hello from div')
puts TagCreator.render(DivTagAdapter.new(div_tag))
# <div>hello from div</div>

div_tag = DivTag.new(Tag.new('small', 'hello'))
puts TagCreator.render(DivTagAdapter.new(div_tag))
# <div><small>hello</small></div>
