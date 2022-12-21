#  aaaa
# b    c
# b    c
#  dddd
# e    f
# e    f
#  gggg

# 0 abcefg          1 => c|f
# 1 cf              8 - 0 => d
# 2 acdeg           
# 3 acdfg           7 - 1 => a
# 4 bcdf            4 - 1 - (8 - 0) => b
# 5 abdfg           9 - 7 - 4 => g
# 6 abdefg          5 - * => f
# 7 acf             1 - ** => c
# 8 abcdefg
# 9 abcdfg
#
# a 02356789
# b 045689
# c 01234789
# d 2345689
# e 0268
# f 013456789
# g 0235689

def analizar_patrones(señales)
    posibles = {}

    ocho = señales.find { |señal| señal.length == 7 }
    cero = 

    posibles[:c] = señales.find { |señal| señal.length == 2 }
    señales.delete posibles[1]

    posibles[7] = señales.find { |señal| señal.length == 3 }
    señales.delete posibles[7]

    posibles[4] = señales.find { |señal| señal.length == 4 }
    señales.delete posibles[4]

    posibles[8] = señales.find { |señal| señal.length == 7 }
    señales.delete posibles[8]
    
    señales = señales.group_by { |señal| señal.length }
    posibles[0] = señales[6]
    posibles[6] = señales[6].clone
    posibles[9] = señales[6].clone

    posibles[2] = señales[5]
    posibles[3] = señales[5].clone
    posibles[5] = señales[5].clone

    posibles.values.select { |arr| arr.size > 1 }.each do |opciones|
        aux = 







end



datos = File.open("input08") { |f| f.map { |l| l.split('|').map { |s| s.split } } }

puts "Parte 1\n"

aux = datos.map { |d| d.last.map(&:length) }.inject(Hash.new(0)) {|h, arr| arr.each { |v| h[v] += 1}; h }

total = { 1 => aux[2], 4 => aux[4], 7 => aux[3], 8 => aux[7] }

puts "Total de dígitos mostrados: #{total}"
puts "Suma: #{total.transform_values.inject(&:+)}"


