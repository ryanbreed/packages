#!/bin/bash

export RUBY_ETC=/app/ruby/2.3.3/etc
test -d $RUBY_ETC || mkdir -p $RUBY_ETC
echo "gem: --no-document" > $RUBY_ETC/gemrc
export PATH=/app/ruby/2.3.3/bin:$PATH
gem install bundler json ffi
cat <<END > /etc/profile.d/ruby.sh
export RUBY_HOME=/app/ruby/runtime
export PATH=\$RUBY_HOME/bin:$PATH
END

ln -sf /app/ruby/2.3.3 /app/ruby/runtime
