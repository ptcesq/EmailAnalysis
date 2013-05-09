require 'matrix'
class MatrixO

  def initialize(row, col)
     @M = Matrix.zero(row, col)
  end

  def print_matrix
    @M.each_slice(@M.column_size) {|r| p r }
  end

  def to_a
    @returnArray = Array.new()
    @M.each_slice(@M.column_size) {|r|  @returnArray.concat r }
    return @returnArray
  end

  def set(row, col, newValue)
    @tempArray = Array.new()
    @M.each_slice(@M.column_size) {|r|  @tempArray << r }
    @targetArray = @tempArray[row]
    @targetArray[col] = newValue
    @tempArray[row] = @targetArray
    @M = Matrix.rows(@tempArray)
  end






end

