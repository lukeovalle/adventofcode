puts "parte 1"

File.open("./input1") do |f|
    puts f.each_cons(2).filter { |a, b| a.to_i < b.to_i }.size
end

puts "parte 2"

File.open("./input1") do |f|
    puts f.each_cons(3).map { |arr| arr.sum(&:to_i) }.each_cons(2).filter { |a, b| a < b }.size
end

