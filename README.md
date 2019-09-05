# `method_object` has moved!

to https://github.com/bukowskis/method_object

## DEPRECATED README:

[![Build Status](https://travis-ci.org/deadlyicon/method_object.png?branch=master)](https://travis-ci.org/deadlyicon/method_object)

# MethodObject

MethodObject is a simple class for facilitating the method object pattern.

You can think of a MethodObject as a proc with the power of a class. Define methods, use instance variables, etc.

## Installation

Add this line to your application's Gemfile:

    gem 'method_object'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install method_object

## Usage

```ruby
  class OpenDoor < MethodObject
    def call door
      open_door!(door)
    end

    def open_door!(door)
      door.open
    end
  end

  OpenDoor.call(my_door)
```

# Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
