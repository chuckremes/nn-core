require 'spec_helper'

module NNCore
  describe "nn_symbol_info" do

    def symbol_info(index)
      pointer = FFI::MemoryPointer.new(NNCore::LibNanomsg::NNSymbolProperties)
      result_size = LibNanomsg.nn_symbol_info(index, pointer, NNCore::LibNanomsg::NNSymbolProperties.size)
      properties = NNCore::LibNanomsg::NNSymbolProperties.new(pointer)

      [result_size, properties]
    end

    context "given an initialized library" do

      it "returns the NN_PUB constant among the symbols with correct attributes values" do

        for i in 0..Float::INFINITY
          result_size, properties = symbol_info(i)

          expect(result_size).to be > 0 if i < 5

          break if result_size == 0

          if properties.name == 'NN_PUB'
            found_nn_pub = true

            expect(properties.value).to eql(32)
            expect(properties.ns).to eql(4)
            expect(properties.type).to eql(0)
            expect(properties.unit).to eql(0)
          end
        end

        expect(found_nn_pub).to be_truthy
      end

    end
  end
end
