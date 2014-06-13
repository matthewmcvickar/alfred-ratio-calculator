#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem
require './bundle/bundler/setup'
require 'alfred'

require './calculate-ratio'

# Grab incoming query.
query = ARGV

# Make a new RatioCalculator object.
ratio_calculation = RatioCalculator.new(query)

# Calculate the ratio.
result = ratio_calculation.calculate_ratio

# puts result

# Return the result
Alfred.with_friendly_error do |alfred|
  feedback = alfred.feedback

  # add an arbitrary feedback
  feedback.add_item({
    :uid      => "",
    :title    => result,
    :subtitle => "Action this item to copy this number to the clipboard",
    :arg      => "arg",
    :valid    => "yes",
  })

  puts feedback.to_xml(ARGV)
end
