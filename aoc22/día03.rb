rucksacks = File.open('input03.txt') do |file|
    file.map do |line|
        h = line.size / 2

        [line[0..(h-1)].chars, line[h..line.size].chars]
    end
end

puts 'Parte 1'

shared_items = rucksacks.map do |bag|
    bag.first & bag.last
end

def priority(c)
    n = c.bytes.first
    if n >= 'a'.bytes.first && n <= 'z'.bytes.first
        n - 'a'.bytes.first + 1
    elsif n >= 'A'.bytes.first && n <= 'Z'.bytes.first
        n - 'A'.bytes.first + 27
    else
        0
    end
end

sum = shared_items.sum(0) { |items| items.map { |a| priority(a) }.sum }

puts "La suma da #{sum}"

puts 'Parte 2'

badges = rucksacks.each_slice(3).map do |bags|
    aux = bags.map { |a| a.flatten }

    aux.first.intersection(*aux.drop(1)).first
end

sum = badges.sum(0) { |badge| priority(badge) }

puts "La suma da #{sum}"

