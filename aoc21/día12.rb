class Grafo
    def initialize
        @adyacencias = []
    end

    def añadir_vértices(a, b)
        añadir_vertice_unidireccional a, b
        añadir_vertice_unidireccional b, a
    end

    def obtener_recorridos(inicio, final, recorrido_actual, acumulados = [])
        return [inicio] if inicio == final




        return [] if inicio == final
        return [] if inicio == inicio.downcase and
        
        inicial = @adyacencias.find { |lista| lista[:valor] == inicio }

        inicial[:adyacentes].map { |v| obtener_recorridos @adyacencias[v], final, recorrido_actual + inicio, acumulados }
    end

    private

    def añadir_vertice_unidireccional(a, b)
        if lista = @adyacencias.find { |lista| lista[:valor] == a }
            if not lista.include? b
                lista[:adyacentes] << b
            end
        else
            @adyacencias << { valor: a, adyacentes: [b] }
        end
    end
end


conexiones = File.open("input12") { |f| f.map { |l| l.chomp.split('-') } }

caminos = Grafo.new

conexiones.each do |a, b|
    caminos.añadir_vértices a, b
end

caminos.obtener_recorridos 'start', 'end'
