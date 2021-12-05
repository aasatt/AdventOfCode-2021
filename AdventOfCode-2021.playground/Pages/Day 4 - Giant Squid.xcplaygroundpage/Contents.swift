//: [Previous](@previous)

import Foundation

guard let file = Bundle.main.url(forResource: "input", withExtension: "txt") else {
    preconditionFailure("Input file not found")
}

let input = try String(contentsOf: file, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)

var numbers = input.components(separatedBy: .newlines).first!.components(separatedBy: .punctuationCharacters).compactMap { Int($0) }

let boardsInput = input.components(separatedBy: "\n\n").dropFirst()


struct Cell {
    let number: Int
    var called: Bool

    init?(_ number: Int?) {
        guard let n = number else { return nil }

        self.number = n
        called = false
    }

    init(number: Int, called: Bool) {
        self.number = number
        self.called = called
    }
}

struct Board {
    var rows: [[Cell]]
    var columns: [[Cell]]
    var win = false

    init(boardString: String) {
        let rows = boardString.components(separatedBy: .newlines).map { $0.components(separatedBy: .whitespaces).compactMap { Cell(Int($0)) } }

        columns = (0 ..< rows.first!.count).map { index in
            return rows.map { $0[index] }
        }

        self.rows = rows
    }


    /// Mark the number and return true if winner
    mutating func mark(number: Int) -> Bool {
        rows = rows.map {
            $0.map {
                Cell(number: $0.number, called: $0.called || number == $0.number)
            }
        }

        columns = columns.map {
            $0.map {
                Cell(number: $0.number, called: $0.called || number == $0.number)
            }
        }

        win = rows.contains { $0.allSatisfy(\.called) } || columns.contains { $0.allSatisfy(\.called) }

        return win
    }
}

var boards = boardsInput.map { Board(boardString: $0) }


var firstWin = false
var lastWin = false

var number = 0

while !numbers.isEmpty && !boards.filter({ !$0.win }).isEmpty && !lastWin {
    number = numbers.removeFirst()

    for i in 0 ..< boards.count {
        guard !boards[i].win else { continue }

        let win = boards[i].mark(number: number)

        if win {
            if !firstWin {
                // MARK: - PART 1

                let unmarkedCells = boards[i].rows.flatMap { $0 }.filter { !$0.called }
                let unmarkedSum = unmarkedCells.map { $0.number }.reduce(0, +)

                let finalScore = unmarkedSum * number

                // Answer
                finalScore

                firstWin = true
            }

            if boards.filter({ !$0.win }).count == 0 {
                // MARK: - Part 2

                let unmarkedCells = boards[i].rows.flatMap { $0 }.filter { !$0.called }
                let unmarkedSum = unmarkedCells.map { $0.number }.reduce(0, +)

                let lastFinalScore = unmarkedSum * number

                // Answer:
                lastFinalScore

                lastWin = true

                break
            }
        }
    }
}
//: [Next](@next)

