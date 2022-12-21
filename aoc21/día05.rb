class Punto
    attr_accessor :x, :y

    def initialize(x, y)
        @x = x
        @y = y
    end

    def ==(other)
        self.class === other and
            other.x == @x and
            other.y == @y
    end

    alias eql? ==

    def +(other)
        Punto.new(@x + other.x, @y + other.y)
    end

    def hash
        @x.hash ^ @y.hash
    end

    def inspect
        "(#{@x}, #{@y})"
    end

    alias to_s inspect
end

class Línea
    attr_accessor :inicio, :fin

    def initialize(inicio, fin)
        @inicio = inicio
        @fin = fin
    end

    def es_ortogonal?
        @inicio.x == @fin.x or
            @inicio.y == @fin.y
    end

    def recorrer
        avance = Punto.new(@fin.x <=> @inicio.x, @fin.y <=> @inicio.y)

        if block_given?
            punto = @inicio
            until punto == @fin
                yield punto
                punto += avance
            end

            yield punto
        else
            to_enum :recorrer
        end
    end
end

líneas = []

File.open("input05") do |f|
    líneas = f.map do |línea|
        match = /(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)/.match línea
        Línea.new(
            Punto.new(match[:x1].to_i, match[:y1].to_i),
            Punto.new(match[:x2].to_i, match[:y2].to_i)
        )
    end
end


puts "Parte 1\n"

líneas_ortogonales = líneas.filter { |línea| línea.es_ortogonal? }

puntos = Hash.new(0)
superpuestos = []

líneas_ortogonales.each do |línea|
    línea.recorrer do |punto|
        puntos[punto] += 1
        if puntos[punto] > 1
            superpuestos << punto
        end
    end
end

superpuestos.uniq!

puts "Se superponen #{superpuestos.size} puntos"


puts "Parte 2\n"

puntos = Hash.new(0)
superpuestos = []

líneas.each do |línea|
    línea.recorrer do |punto|
        puntos[punto] += 1
        if puntos[punto] > 1
            superpuestos << punto
        end
    end
end
superpuestos.uniq!


puts "Se superponen #{superpuestos.size} puntos"
