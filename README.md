# nn-core

[![Build Status](https://travis-ci.org/chuckremes/nn-core.svg?branch=master)](https://travis-ci.org/chuckremes/nn-core)

nn-core is a very thin FFI wrapper around the nanomsg library. The intention is to provide a very
simple wrapper that hews as close to the C API as possible. Other gems that want to offer a more
idiomatic API for Ruby should require this gem and build a nice Ruby API with it.

For more information on nanomsg, please visit its website:

http://nanomsg.org

# Bundler Installation

1. Add this line to your `Gemfile`:

    gem 'nn-core'

2. Install the gem using bundler:

    bundle install

3. In your code, do:

    ```ruby
    require "nn-core"
    ```

# Manual Installation

1. Clone this repository

    git clone https://github.com/chuckremes/nn-core.git

2. Install the gem dependencies:

    bundle install

3. Build libnanomsg:

    pushd ext && bundle exec rake && popd

4. Run the tests to ensure everything works fine:

    bundle exec rake spec

# License

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
