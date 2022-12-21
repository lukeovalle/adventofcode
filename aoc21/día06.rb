def iterar_pecesitos(pecesitos)
    aux = Hash.new(0)
    pecesitos.each_pair do |días_restantes, cantidad|
        if not días_restantes.zero?
            aux[días_restantes - 1] += cantidad
        else
            aux[8] += cantidad
            aux[6] += cantidad
        end
    end

    aux
end

valores_iniciales = File.open("input06") { |f| f.read.split(',').map(&:to_i) }

# Diccionario de hashes que mapea días_para_duplicarse -> cantidad de pecesitos
pecesitos = valores_iniciales.group_by { |i| i}.transform_values { |v| v.size }

puts "Parte 1\n"

días = 80

días.times do
    pecesitos = iterar_pecesitos(pecesitos)
end

puts "Hay #{pecesitos.transform_values.sum} pecesitos después de #{días} días"

puts "\n\nParte 2\n"

días = 256 - días

días.times do
    pecesitos = iterar_pecesitos(pecesitos)
end

puts "Hay #{pecesitos.transform_values.sum} pecesitos después de #{días} días"
