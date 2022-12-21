puts "parte 1"

File.open("input02") do |f|
    h = f.map { |línea| línea.split }.group_by { |comando, pasos| comando.to_sym }.transform_values! { |a| a.map { |a, b| b.to_i }.sum }
    forward = h[:forward]
    depth = h[:down] - h[:up]
    puts "avance: #{forward}, profundidad: #{depth}"
    puts "producto: #{forward * depth}"
end

puts "parte 2"

File.open("input02") do |f|
    aim = depth = forward = 0
    f.map { |línea| a = línea.split; [a[0].to_sym, a[1].to_i] }.each do |comando, cantidad|
        case comando
        when :forward
            depth += cantidad * aim
            forward += cantidad
        when :down
            aim += cantidad
        when :up
            aim -= cantidad
        end
    end
    puts "aim: #{aim}, profundidad: #{depth}, avance: #{forward}"
    puts "producto: #{depth * forward}"
end

