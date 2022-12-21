require 'set'

class Punto
    attr_accessor :x, :y

    def initialize(x, y)
        @x = x
        @y = y
    end

    def hash
        @x.hash ^ @y.hash
    end

    def eql?(otro)
        @x == otro.x and @y == otro.y
    end
end

def menor_arriba(mapa, i, j)
    if i == 0
        true
    else
        mapa[i][j] < mapa[i-1][j]
    end
end

def menor_abajo(mapa, i, j)
    if i == mapa.size - 1
        true
    else
        mapa[i][j] < mapa[i+1][j]
    end
end

def menor_izq(mapa, i, j)
    if j == 0
        true
    else
        mapa[i][j] < mapa[i][j-1]
    end
end

def menor_der(mapa, i, j)
    if j == mapa[i].size - 1
        true
    else
        mapa[i][j] < mapa[i][j+1]
    end
end


mapa = File.open("input09") { |f| f.map { |línea| línea.chomp.each_char.map(&:to_i) } }

puts "Parte 1\n"

mínimos = []

mapa.each_with_index do |fila, i|
    fila.each_with_index do |valor, j|
        if menor_arriba(mapa, i, j) &&
                menor_abajo(mapa, i, j) &&
                menor_izq(mapa, i, j) &&
                menor_der(mapa, i, j)
            mínimos << {x: i, y: j, valor: valor}
        end
    end
end

puts "cantidad de mínimos: #{mínimos.size}"
puts "suma de niveles de riesgo: #{mínimos.map { |v| v[:valor] + 1 }.sum}"


puts "\n\nParte 2\n"

def comparar_y_añadir(mapa, posiciones, anterior, actual)
    return false if mapa[actual.x][actual.y] == 9

    return false if posiciones.include? actual

    posiciones << actual
    true
end


def buscar_miembros_basin(mapa, posiciones, actual)
    if actual.x > 0
        siguiente = Punto.new(actual.x - 1, actual.y)
        seguir = comparar_y_añadir(mapa, posiciones, actual, siguiente)
        
        buscar_miembros_basin(mapa, posiciones, siguiente) if seguir
    end
    if actual.x < mapa.size - 1
        siguiente = Punto.new(actual.x + 1, actual.y)
        seguir = comparar_y_añadir(mapa, posiciones, actual, siguiente)

        buscar_miembros_basin(mapa, posiciones, siguiente) if seguir
    end
    if actual.y > 0
        siguiente = Punto.new(actual.x, actual.y - 1)
        seguir = comparar_y_añadir(mapa, posiciones, actual, siguiente)

        buscar_miembros_basin(mapa, posiciones, siguiente) if seguir
    end
    if actual.y < mapa[actual.x].size - 1
        siguiente = Punto.new(actual.x, actual.y + 1)
        seguir = comparar_y_añadir(mapa, posiciones, actual, siguiente)

        buscar_miembros_basin(mapa, posiciones, siguiente) if seguir
    end
end

basins = Set.new

mínimos.each do |mín|
    inicial = Punto.new(mín[:x], mín[:y])

    next if basins.any? { |basin| basin.include? inicial }

    posiciones = Set.new
    posiciones << inicial

    buscar_miembros_basin(mapa, posiciones, inicial)

    next if basins.include? posiciones

    basins << posiciones
end

resultado = basins.map(&:size).sort.last(3).reduce(1, :*)

puts "Cantidad de basins: #{basins.size}"
puts "producto de los tres más grandes: #{resultado}"
