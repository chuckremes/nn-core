nn-core
-------

nn-core is a very thin FFI wrapper around the nanomsg library. The intention is to provide a very
simple wrapper that hews as close to the C API as possible. Other gems that want to offer a more
idiomatic API for Ruby should require this gem and build a nice Ruby API with it.

For more information on nanomsg, please visit its website:

http://nanomsg.org

Installation
------------

1. Make sure to build libnanomsg first by following these instructions:

http://github.com/250bpm/nanomsg

2. git clone git://github.com/chuckremes/nn-core.git

3. cd nn-core

4. ruby -S gem build nn-core.gemspec

5. ruby -S gem install nn-core*.gem

6. In your code, do:

```ruby
require "nn-core"
```

License
-------

(The MIT License)

Copyright (c) 2013 Chuck Remes

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
