# encoding: utf-8

class RatioCalculator
  def initialize(query)
    @query = query
  end

  def ratio
    @query.each_with_index do |number, index|
      return(ratio_for_index(index)) if placeholder?(number)
    end
  end

  protected

  def placeholder?(number)
    !number?(number)
  end

  def number?(number)
    /[0-9]+/.match(number.to_s)
  end

  def ratio_for_index(index)
    case index
    when 0 then ratio_via_multiplication(b, c, d)
    when 1 then ratio_via_division(a, c, d)
    when 2 then ratio_via_multiplication(d, a, b)
    when 3 then ratio_via_division(c, a, b)
    end
  end

  def ratio_via_multiplication(x, y, z)
    ratio_via(:*, x, y, z)
  end

  def ratio_via_division(x, y, z)
    ratio_via(:/, x, y, z)
  end

  def ratio_via(operation, x, y, z)
    round(x.to_f.send(operation, y.to_f / z.to_f))
  end

  def round(number)
    sprintf('%.2f', number).chomp('.00')
  end

  def a
    @query[0]
  end

  def b
    @query[1]
  end

  def c
    @query[2]
  end

  def d
    @query[3]
  end
end
