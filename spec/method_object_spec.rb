require 'spec_helper'

describe MethodObject do

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

  it 'should work' do

    expect{ OpenChest.call               }.to raise_error ArgumentError, 'color is a required option for OpenChest'
    expect{ OpenChest.call(size: 14)     }.to raise_error ArgumentError, 'color is a required option for OpenChest'
    expect{ OpenChest.call(color: 'red') }.to_not raise_error

    size, color = OpenChest.call(color: 'red')
    expect(size).to eq 12
    expect(color).to eq 'red'

    size, color = OpenChest.call(color: 'blue', size: 45)
    expect(size).to eq 45
    expect(color).to eq 'blue'

    size, color = OpenChest.call(color: nil, size: nil)
    expect(size).to be_nil
    expect(color).to be_nil


    expect{ OpenMagicChest.call                             }.to raise_error ArgumentError, 'size is a required option for OpenMagicChest'
    expect{ OpenMagicChest.call(size: 14)                   }.to raise_error ArgumentError, 'color is a required option for OpenMagicChest'
    expect{ OpenMagicChest.call(color: 'red')               }.to raise_error ArgumentError, 'size is a required option for OpenMagicChest'
    expect{ OpenMagicChest.call(size: 14, key_type: :a)     }.to raise_error ArgumentError, 'color is a required option for OpenMagicChest'
    expect{ OpenMagicChest.call(color: 'red', key_type: :a) }.to raise_error ArgumentError, 'size is a required option for OpenMagicChest'
    expect{ OpenMagicChest.call(color: 'red')               }.to raise_error ArgumentError, 'size is a required option for OpenMagicChest'
    expect{ OpenMagicChest.call(size: 14, color: 'red')     }.to_not raise_error

    size, color, key_type = OpenMagicChest.call(size: 14, color: 'red')
    expect(size).to eq 14
    expect(color).to eq 'red'
    expect(key_type).to eq :upside

    size, color, key_type = OpenMagicChest.call(size: 18, color: 'green', key_type: :b)
    expect(size).to eq 18
    expect(color).to eq 'green'
    expect(key_type).to eq :b

    size, color, key_type = OpenMagicChest.call(size: nil, color: nil, key_type: nil)
    expect(size).to be_nil
    expect(color).to be_nil
    expect(key_type).to be_nil

  end
end
