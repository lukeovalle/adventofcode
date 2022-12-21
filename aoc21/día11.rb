def incrementar(mapa)
    propagados = []
    mapa.each_with_index do |fila, i|
        fila.each_with_index do |energía, j|
            mapa[i][j] += 1
            if mapa[i][j] > 9
                propagar(mapa, i, j, propagados)
            end
        end
    end
end

# mapa es un arreglo de arreglos de valores de energía
# propagados es un arreglo de [x, y]
def propagar(mapa, x, y, propagados)
    return if not x.between? 0, mapa.size - 1
    return if not y.between? 0, mapa[x].size - 1

    return if propagados.include? [x, y]

    mapa[x][y] += 1

    if mapa[x][y] > 9
        propagados << [x, y]

        ((-1..1).to_a.product((-1..1).to_a) - [[0 ,0]]).each do |arr|
            propagar mapa, x + arr[0], y + arr[1], propagados
        end
    end
end

# agarra todos los valores > 9 y los pone en 0, devuelve la cantidad de flasheadas
def flashear(mapa)
    acumulador = 0
    mapa.each_with_index do |fila, i|
        fila.each_with_index do |energía, j|
            if  mapa[i][j] > 9
                mapa[i][j] = 0
                acumulador += 1
            end
        end
    end

    acumulador
end

def imprimir(mapa)
    mapa.each do |fila|
        fila.each do |c|
            print c == 0 ? "\e[7m#{c.to_s}\e[0m" : c.to_s
        end
        putc "\n"
    end
end

mapa = File.open("input11") { |f| f.map { |línea| línea.chomp.each_char.map { |c| c.to_i } } }

puts "Parte 1\n"

total = 100.times.sum do
    imprimir mapa
    puts "-"*10
    incrementar mapa
    flashear mapa
end

puts "Hubo #{total} flashes"

puts "\nParte 2\n"

iteraciones = 100
(101..).each do |i|
    imprimir mapa
    puts "-"*10
    incrementar mapa
    total = flashear mapa
    iteraciones = i
    break if total == 100
end

imprimir mapa

puts "Fueron #{iteraciones} iteraciones"
