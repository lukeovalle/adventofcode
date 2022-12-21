class Pila
    def initialize
        @valores = []
    end

    def meter(valor)
        @valores << valor
    end

    def sacar
        @valores.pop
    end

    def vacía?
        @valores.empty?
    end

    def sacar_todo
        if block_given?
            while objeto = sacar
                yield objeto
            end
        else
            to_enum :sacar_todo
        end
    end
end


datos = File.open("input10") { |f| f.map(&:chomp) }

cierres = { ')' => '(',
            ']' => '[',
            '}' => '{',
            '>' => '<'
}

valores = { ')' => 3,
            ']' => 57,
            '}' => 1197,
            '>' => 25137
}


puts "Parte 1\n"

errores = []
líneas_incompletas = []

datos.each do |línea|
    pila = Pila.new
    incompleta = true

    línea.each_char do |char|
        if %w(\( [ { <).include? char
            pila.meter char
        else
            if (último = pila.sacar) != cierres[char]
                errores << char
                pila.meter último
                incompleta = false

                break
            end
        end
    end

    líneas_incompletas << pila if incompleta
end

puntaje = errores.map { |c| valores[c] }.sum

puts "puntaje: #{puntaje}"

puts "\nParte 2\n"

valores_p2 = { '(' => 1,
               '[' => 2,
               '{' => 3,
               '<' => 4
}

puntajes_p2 = líneas_incompletas.map do |pila|
    pila.sacar_todo.inject(0) do |acum, char|
        acum * 5 + valores_p2[char]
    end
end

medio = puntajes_p2.sort[puntajes_p2.size/2]

puts "Puntaje medio: #{medio}"
