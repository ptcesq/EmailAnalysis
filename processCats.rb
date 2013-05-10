require_relative 'matrix_o'

M = MatrixO.new(3,13)
M.print_matrix


File.open('test.cats', 'r') do |f1|
  while line = f1.gets
    @values = line.split(',')
    @row = @values[0].to_i
    @row = @row - 1
    @col = @values[1].to_i
    @col = @col - 1
    @newVal = @values[2].to_i
    M.set(@row, @col, @newVal)
    puts line
    M.print_matrix
  end
end

puts("----------------------")
puts("Final Matrix")
puts("")
M.print_matrix


puts("----------------------")
puts("Final Array ")
puts("")
A = M.to_a
A.inspect