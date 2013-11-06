class MethodObject

  VERSION = '0.1.0'

  class << self
    private :new

    def call *args, &block
      new.call(*args, &block)
    end

    def to_proc
      method(:call).to_proc
    end
  end

  def call
    raise "#{self.class}#call is not defined"
  end

end
