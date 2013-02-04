
module LibC
  extend FFI::Library
  # figures out the correct libc for each platform including Windows
  library = ffi_lib(FFI::Library::LIBC).first

  # Size_t may not work properly on Windows so redefine that type
  find_type(:size_t) rescue typedef(:ulong, :size_t)
end # module LibC
