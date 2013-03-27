module NNCore

  # To simplify management of constants in language bindings that cannot
  # parse or directly utilize a C header file, the library provides the
  # nn_symbol function. This function returns a string and an integer 
  # value so that bindings authors can easily setup all constants and 
  # their values without worrying about copy/paste or transcription
  # errors every time the underlying library is changed.
  #
  # For documentation on all possible constants, please refer to the
  # man pages at nanomsg.org
  #
  index = 0
  while true
    value = FFI::MemoryPointer.new(:int)

    constant_string = LibNanomsg.nn_symbol(index, value)
    break if constant_string.nil?

    const_set(constant_string, value.read_int)
    index += 1
  end
  
  # This constant is not exported by nn_symbol. It is also of type size_t.
  NN_MSG = -1
end
