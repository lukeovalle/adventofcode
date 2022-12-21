pos = File.read("input07") { |f| f.read }.split(',').map(&:to_i)

min = (pos.min..pos.max).map { |i| pos.sum { |j| (i - j).abs } }.min

puts "Parte 1\n"

puts "Se necesita #{min} de combustible"

puts "\n\nParte 2\n"

def sumatorio(n)
    n*(n+1)/2
end

min = (pos.min..pos.max).map { |i| pos.sum { |j| sumatorio((i - j).abs) } }.min

puts "Se necesita #{min} de combustible"
