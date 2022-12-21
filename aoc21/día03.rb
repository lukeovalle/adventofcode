TOTAL_BITS = 12

puts "parte 1\n"

bits = [0] * TOTAL_BITS

values = File.open("input03") { |f| f.each_line.to_a }

values.each do |s|
    s.each_char.take(TOTAL_BITS).each_with_index { |c, i| bits[i] += c.to_i}
end

gamma = bits.map { |b| b > (values.size / 2) ? 1 : 0 }.join.to_i(2)
epsilon = bits.map { |b| b < (values.size / 2) ? 1 : 0 }.join.to_i(2)

puts "gamma: #{gamma}, epsilon: #{epsilon}"
puts "power consumption: #{ gamma * epsilon}"


puts "\n\nparte 2\n"

# oxigeno, co2
ratings = {oxygen: values, co_2: values}
ratings.each_key do |key|
    TOTAL_BITS.times do |i|
        aux = ratings[key].group_by { |str| str[i].to_i }
        sorted = aux.each_value.sort { |a, b| b.size <=> a.size }

        ratings[key] = if sorted.first.size == sorted.last.size
                           aux[key == :oxygen ? 1 : 0]
                       else
                           key == :oxygen ? sorted.first : sorted.last
                       end

        break if ratings[key].size == 1
    end
end
ratings.transform_values! { |v| v[0].to_i(2) }

puts "oxygen rating: #{ratings[:oxygen]}, co2 rating: #{ratings[:co_2]}"
puts "life support rating: #{ratings[:oxygen] * ratings[:co_2]}"



