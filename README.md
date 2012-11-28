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
        car = Car.new
        car.location = GoogleMaps.find(location)
        car.start!
        car.speed = speed
        return car
      end

    end

Rather then complecting your Car object with more the one method that all
have to do with driving to a location you can use a method object to break
up your code without cluttering Car

    class Car

      class DriveTo < MethodObject

        # Note: call takes no arguments. The hash given to Car.call is
        # turn into instance variables
        def call
          find_location!
          start_car!
          set_speed!
          return car
        end

        def car
          @car ||= Car.new
        end

        def find_location!
          car.location = GoogleMaps.find(@location)
        end

        def start_car!
          car.start!
        end

        def set_speed!
          car.speed = @speed
        end

      end

      def drive_to location, speed=:slow
        DriveTo.call(:location => location, :speed => speed)
      end

    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
