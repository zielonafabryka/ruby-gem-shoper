#!/bin/bash
rm shoper*.gem
gem build shoper
gem install ./shoper*.gem
