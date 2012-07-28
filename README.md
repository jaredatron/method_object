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


    class Car

      # take the following long method
      def drive_to location, speed=:slow
        # find location
        Lorem ipsum dolor sit amet, consectetur adipisicing
        elit, sed do eiusmod tempor incididunt ut labore

        # set speed
        et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut
        aliquip ex ea commodo

        # start car
        consequat. Duis aute irure dolor in reprehenderit in voluptate
        cillum dolore eu fugiat nulla pariatur. Excepteur
        proident, sunt in culpa qui officia deserunt mollit anim

        # go
        id est laborum.
      end

    end

Rather then complecting your Car object with more the one method that all
have to do with driving to a location you can use a method object to break
up your code without cluttering Car

    class Car

      class DriveTo < MethodObject
        def call location, speed
          @location, @speed = location, speed
          find_location
          set_speed
          start_car
          go
        end

        def find_location
          Lorem ipsum dolor sit amet, consectetur adipisicing
          elit, sed do eiusmod tempor incididunt ut labore
        end

        def set_speed
          et dolore magna aliqua. Ut enim ad minim veniam,
          quis nostrud exercitation ullamco laboris nisi ut
          aliquip ex ea commodo
        end

        def start_car
          consequat. Duis aute irure dolor in reprehenderit in voluptate
          cillum dolore eu fugiat nulla pariatur. Excepteur
          proident, sunt in culpa qui officia deserunt mollit anim
        end

        def go
          id est laborum.
        end


      end

      def drive_to location, speed=:slow
        DriveTo.call(location, speed)
      end

    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
