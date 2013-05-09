require 'matrix'
class MatrixO

  def initialize(r, c)
     @M = Matrix.zero(r,c)
  end

  def print_matrix()
    @M.each_slice(@M.column_size) {|r| p r }
  end




end

