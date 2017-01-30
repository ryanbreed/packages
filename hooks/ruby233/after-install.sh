#!/bin/bash
echo "gem: --no-document" > /app/ruby/2.3.3/etc/gemrc
export PATH=/app/ruby/2.3.3/bin:$PATH
gem install bundler
