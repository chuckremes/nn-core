require 'spec_helper'

module NNCore
  describe "nn_symbol" do

    context "given an initialized library" do

      it "returns a string constant given an index of 0" do
        value = FFI::MemoryPointer.new(:int)

        constant_string = LibNanomsg.nn_symbol(0, value)
        expect(constant_string).to be_a(String)
      end

      it "returns an integer value in the second parameter given an index of 0" do
        value = FFI::MemoryPointer.new(:int)

        constant_string = LibNanomsg.nn_symbol(0, value)
        expect(value.read_int).to be >= 0
      end

    end
  end
end
