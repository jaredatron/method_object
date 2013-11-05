# MethodObject

MethodObject is a simple class for facilitating the method object pattern.

You can think of a MethodObject as a proc with private methods.

## Installation

Add this line to your application's Gemfile:

    gem 'method_object'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install method_object

## Usage

```ruby
  class OpenChest < MethodObject
    option :size,  default: 12
    option :color, required: true
    def call
      [@size, color]
    end
  end

  class OpenMagicChest < OpenChest
    option :size, required: true
    option :key_type, default: ->{ :upside }
    def call
      [size, color, @key_type]
    end
  end
```

# Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
