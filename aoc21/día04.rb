class Board
    # arr es un arreglo de filas
    def initialize(arr)
        @rows = arr.map { |vals| vals.map { |val| Number.new(val) } }
        @columns = Array.new(5) { Array.new(5) }
        @rows.each_with_index do |row, i|
            row.each_with_index do |val, j|
                @columns[j][i] = val
            end
        end
    end

    def mark_number(number)
        @rows.each { |row| row.select { |n| n.value == number }&.each(&:mark) }
    end

    def check_rows
        @rows.each { |row| return true if row.all? { |n| n.marked } }
        false
    end

    def check_columns
        @columns.each { |col| return true if col.all? { |n| n.marked } }
        false
    end

    def score
        @rows.map { |row| row.select { |n| not n.marked }.sum { |n| n.value } }.sum
    end

    def to_s
        @rows.map { |row| row.map { |n| n.to_s }.join (" ") }.join("\n")
    end
end

class Number
    attr_reader :value, :marked

    def initialize(val)
        @value = val.to_i
        @marked = false
    end

    def mark
        @marked = true
    end

    def to_s
        "%s%2d " % [@marked ? '*' : ' ', @value]
    end
end

numbers = []
boards = [] 

puts "parte 1\n"

File.open("input04") do |f|
    numbers = f.readline.split(',').map(&:to_i)

    f.reject { |line| line == "\n" }
        .map { |line| line.split.map(&:to_i) }
        .each_slice(5) { |arr| boards << Board.new(arr) }
end

winners = []
winner_numbers = []

numbers.each do |n|
    boards.clone.each do |board|
        board.mark_number n
        if board.check_rows or board.check_columns
            boards.delete board
            winners << board 
            winner_numbers << n
        end
    end
    break if boards.empty?
end

puts "first winner"
puts "number: #{winner_numbers.first}"
puts "board:"
puts winners.first
puts "score: #{winners.first.score}"
puts "product: #{winner_numbers.first * winners.first.score}" 

puts "\n\nlast winner"
puts "number: #{winner_numbers.last}"
puts "board:"
puts winners.last
puts "score: #{winners.last.score}"
puts "product: #{winner_numbers.last * winners.last.score}" 
