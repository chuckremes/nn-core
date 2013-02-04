require 'spec_helper'

module NNCore
  describe "nn_bind" do

    context "given an initialized library" do
      before(:each) { LibNanomsg.nn_init }
      after(:each) { LibNanomsg.nn_term }

      it "returns 0 and populates the pointers with the major, minor and patch version numbers" do
        major = FFI::MemoryPointer.new(:int)
        minor = FFI::MemoryPointer.new(:int)
        patch = FFI::MemoryPointer.new(:int)

        # there is no return value for this function
        LibNanomsg.nn_version(major, minor, patch)
        
        major.read_int.should >= 0
        minor.read_int.should >= 0
        patch.read_int.should >= 0
      end

    end
  end
end
