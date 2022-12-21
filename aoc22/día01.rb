calories = File.open('./input01.txt') do |file|
    file.slice_after("\n").map{ |arr| arr.map(&:to_i).sum }
end

puts 'Parte 1'
puts "mayor cantidad de calorías: #{calories.max}"

top_3 = calories.sort_by(&:-@).take(3).sum

puts 'Parte 2'
puts "Suma del Top 3: #{top_3}"

