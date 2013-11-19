require 'spec_helper'

describe MethodObject do

  let(:block) { lambda{} }

  class SimpleMethodObject < MethodObject
    def call *args, &block
      [args, block]
    end
  end

  class SimpleMethodObjectWithNoCallMethod < MethodObject
  end

  shared_examples 'a method object' do
    describe '.new' do
      it 'should be private' do
        expect(subject.private_methods.map(&:to_s)).to include 'new'
      end
    end
    describe '.to_proc' do
      it 'should return a proc that calls call' do
        expect(subject.to_proc).to be_a Proc
        expect(subject).to receive(:call).with(:a,:b)
        subject.to_proc.call(:a, :b)
      end
    end
  end


  describe SimpleMethodObjectWithNoCallMethod do
    subject{ SimpleMethodObjectWithNoCallMethod }
    it_behaves_like 'a method object'
    describe '.call' do
      it 'should raise a SimpleMethodObjectWithNoCallMethod#call is not defined error' do
        expect{ subject.call }.to raise_error StandardError, "SimpleMethodObjectWithNoCallMethod#call is not defined"
      end
    end
  end

  describe SimpleMethodObject do
    subject{ SimpleMethodObject }
    it_behaves_like 'a method object'
    it "should curry all args and block to #call" do
      expect( subject.call(1,2,3, &block)         ).to eq [[1,2,3], block]
      expect( subject.to_proc.call(1,2,3, &block) ).to eq [[1,2,3], block]
    end
  end

  describe 'used as a block' do
    it 'should work' do
      expect( [1,2,3].map(&SimpleMethodObject) ).to eq [
        [[1], nil],
        [[2], nil],
        [[3], nil],
      ]
    end
  end

  describe 'used to define a method' do
    it 'should work' do
      _class = Class.new do
        define_method :foo, &SimpleMethodObject
      end

      expect( _class.new.foo('hello', :world, &block) ).to eq [['hello', :world], block]
    end
  end

end
