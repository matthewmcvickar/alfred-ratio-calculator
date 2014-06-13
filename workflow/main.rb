# encoding: utf-8

require './calculate-ratio'

# Grab incoming query.
query = ARGV

# Make a new RatioCalculator object.
ratio_calculation = RatioCalculator.new(query)

# Calculate the ratio.
result = ratio_calculation.ratio

# Handle result
title        = 'Calculate the missing number in a ratio equation.'
instructions = 'Enter three numbers and a non-number to represent an 𝒂/𝒃=𝒄/𝒅 equation. E.g.: 2 4 ? 10'

# While it's receiving data and input hasn't been finished typing, the result may
# be either a NaN (e.g., 'x 2') or an array of numbers (e.g., '2 4 3'). Until we
# get a workable input, retain the on-screen instructions.
if result == 'NaN' || result.kind_of?(Array)
  valid    = 'no'
  result   = title
  subtitle = instructions

# Some ratio equations may be valid but return a value of infinity (e.g., x 1 2 0).
# In this case, lightly suggest altering the eqation.
elsif result == 'Inf'
  valid    = 'no'
  result   = '∞'
  subtitle = 'Is that right? ' + instructions

# Otherwise, show them the answer!
else
  valid    = 'yes'
  subtitle = 'Action this item to copy this number to the clipboard.'
end

# Return the result
puts <<-eos
  <?xml version='1.0'?>
  <items>
    <item valid='#{valid}' uid='#{result}' arg='#{result}'>
        <title>#{result}</title>
        <subtitle>#{subtitle}</subtitle>
      </item>
    </items>
  eos
