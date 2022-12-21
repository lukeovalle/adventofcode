strategies = File.open('input02.txt') do |file|
    file.map(&:split)
end


puts 'Parte 1'

decode = {
    # The other player: A B C. Me: X Y Z
    # rock: 0, paper: 1, scissors: 2
    'A' => 0, 'X' => 0,
    'B' => 1, 'Y' => 1,
    'C' => 2, 'Z' => 2
}

decoded = strategies.map { |s| s.map { |c| decode[c] } }

# rows are the opponent, R|P|S
# columns are my pick, R/P/S
points = [
    [1 + 3, 2 + 6, 3 + 0],
    [1 + 0, 2 + 3, 3 + 6],
    [1 + 6, 2 + 0, 3 + 3]
]

total_points = decoded.map { |strat| points[strat.first][strat.last] }.sum

puts "Total de puntos: #{total_points}"

puts 'Parte 2'

# If the opponent picks A, and X means I lose, he picks rock and I scissors
# columns are lose | draw | win
# rows are (his pick) rock / paper / scissors
#
# matrix:
# R+L R+D R+W   S+0 R+3 P+6
# P+L P+D P+W   R+0 P+3 S+6
# S+L S+D S+W   P+0 S+3 R+6
points = [
    [3 + 0, 1 + 3, 2 + 6],
    [1 + 0, 2 + 3, 3 + 6],
    [2 + 0, 3 + 3, 1 + 6]
]

total_points = decoded.map { |strat| points[strat.first][strat.last] }.sum

puts "Total de puntos: #{total_points}"
