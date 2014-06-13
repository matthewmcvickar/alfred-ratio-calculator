#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem
require 'bundle/bundler/setup'
require 'alfred'

require File.expand_path('./ratio-calculator.rb', __FILE__)

# Grab query from Alfred.
query = ARGV[0]

# Make a new RatioCalculator object.
ratio_calculation = RatioCalculator.new(query)

# Calculate the ratio.
result = ratio_calculation.calculate_ratio

# Return the result
Alfred.with_friendly_error do |alfred|
  feedback = alfred.feedback

  # add an arbitrary feedback
  feedback.add_item({
    :uid      => ""                                                      ,
    :title    => result                                                  ,
    :subtitle => "Action this item to copy this number to the clipboard" ,
    :arg      => "arg" ,
    :valid    => "yes"                  ,
  })

  puts feedback.to_xml(ARGV)
end
