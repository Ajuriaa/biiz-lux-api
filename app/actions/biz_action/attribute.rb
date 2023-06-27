class BizAction::Attribute
  attr_reader :name, :default
  attr_writer :value

  def initialize(name, opts = {})
    @name = name.to_sym
    @value = nil
    @default = opts[:default]
  end

  def value
    empty = @value.nil? || (@value.is_a?(String) && @value.blank?)
    empty ? @default : @value
  end
end
