
module NNCore
  module LibNanomsg
    extend FFI::Library

    begin
      # bias the library discovery to a path inside the gem first, then
      # to the usual system paths
      inside_gem = File.join(File.dirname(__FILE__), '..', '..', 'ext')
      local_path = FFI::Platform::IS_WINDOWS ? ENV['PATH'].split(';') : ENV['PATH'].split(':')
      library_name = "libnanomsg"
      LIB_PATHS = [
        inside_gem, '/usr/local/lib', '/opt/local/lib', '/usr/local/homebrew/lib', '/usr/lib64'
      ].map{|path| "#{path}/#{library_name}.#{FFI::Platform::LIBSUFFIX}"}
      ffi_lib(LIB_PATHS + [library_name])
    rescue LoadError
      if LIB_PATHS.push(*local_path).any? {|path|
        File.file? File.join(path, "#{library_name}.#{FFI::Platform::LIBSUFFIX}")}
        warn "Unable to load this gem. The #{library_name} library exists, but cannot be loaded."
        warn "If this is Windows:"
        warn "-  Check that you have MSVC runtime installed or statically linked"
        warn "-  Check that your DLL is compiled for #{FFI::Platform::ADDRESS_SIZE} bit"
      else
        warn "Unable to load this gem. The #{library_name} library (or DLL) could not be found."
        warn "If this is a Windows platform, make sure #{library_name}.dll is on the PATH."
        warn "If the DLL was built with mingw, make sure the other two dependent DLLs,"
        warn "libgcc_s_sjlj-1.dll and libstdc++6.dll, are also on the PATH."
        warn "For non-Windows platforms, make sure #{library_name} is located in this search path:"
        warn LIB_PATHS.inspect
      end
      raise LoadError, "The #{library_name} library (or DLL) could not be loaded"
    end
    # Size_t not working properly on Windows
    find_type(:size_t) rescue typedef(:ulong, :size_t)

    attach_function :nn_symbol, [:int, :pointer], :string, :blocking => true
    attach_function :nn_symbol_info, [:int, :pointer, :int], :int, :blocking => true

    attach_function :nn_errno, [], :int, :blocking => true
    attach_function :nn_strerror, [:int], :string, :blocking => true
    attach_function :nn_socket, [:int, :int], :int, :blocking => true
    attach_function :nn_close, [:int], :int, :blocking => true

    attach_function :nn_getsockopt, [:int, :int, :int, :pointer, :pointer], :int, :blocking => true
    attach_function :nn_setsockopt, [:int, :int, :int, :pointer, :size_t], :int, :blocking => true
    attach_function :nn_bind, [:int, :string], :int, :blocking => true
    attach_function :nn_connect, [:int, :string], :int, :blocking => true
    attach_function :nn_shutdown, [:int, :int], :int, :blocking => true
    attach_function :nn_send, [:int, :pointer, :size_t, :int], :int, :blocking => true
    attach_function :nn_recv, [:int, :pointer, :size_t, :int], :int, :blocking => true
    attach_function :nn_term, [], :void, :blocking => true

    attach_function :nn_poll, [:pointer, :int, :int], :int, :blocking => true

    # functions for working with raw buffers
    attach_function :nn_sendmsg, [:int, :pointer, :int], :int, :blocking => true
    attach_function :nn_recvmsg, [:int, :pointer, :int], :int, :blocking => true
    attach_function :nn_allocmsg, [:size_t, :int], :pointer, :blocking => true
    attach_function :nn_reallocmsg, [:void, :size_t], :pointer, :blocking => true
    attach_function :nn_freemsg, [:pointer], :int, :blocking => true
  end
end
