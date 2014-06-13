#!/usr/bin/env ruby
# encoding: utf-8

class RatioCalculator < ::Alfred::Handler::Base

  def initialize(query)
    super

    @query = query
  end

  # Round to the decimal specified in the argument.
  def round_to_specified_decimal(number)
    result = sprintf('%.2f', number)

    # Remove trailing zero and decimal if it's just an integer.
    return result.chomp('.00')
  end

  # Calculate value of missing number.
  def calculate_ratio_via_multiplication(x, y, z)
    result = x.to_f*(y.to_f/z.to_f)
    return round_to_specified_decimal(result)
  end

  def calculate_ratio_via_division(x, y, z)
    result = x.to_f/(y.to_f/z.to_f)
    return round_to_specified_decimal(result)
  end

  # Find which of the four numbers is missing and do the right calculation.
  def determine_correct_ratio_calculation(numbers)

    # Extract numbers from arguments remaining after the options specified above.
    a, b, c, d = numbers

    numbers.each_with_index do |number, index|

      # Check for which part of the series isn't a number.
      if not (/[0-9]+/).match(number.to_s)

        # Perform the appropriate calculation.
        if index == 0
          result = calculate_ratio_via_multiplication(b, c, d)
        elsif index == 1
          result = calculate_ratio_via_division(a, c, d)
        elsif index == 2
          result = calculate_ratio_via_multiplication(d, a, b)
        elsif index == 3
          result = calculate_ratio_via_division(c, a, b)
        end

      end
    end
  end

  # Do calculation
  def calculate_ratio
    return determine_correct_ratio_calculation(@query)
  end

end
