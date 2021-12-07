//: [Previous](@previous)

import Foundation

guard let file = Bundle.main.url(forResource: "input", withExtension: "txt") else {
    preconditionFailure("Input file not found")
}

let inputString = try String(contentsOf: file, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)

var input = inputString.components(separatedBy: .punctuationCharacters).map { Int($0)! }

let totalDays = 256

let maxDaysToSpawn = 8

var list = [Int: Int]()

(0 ... 8).forEach {
    list[$0] = .zero
}

input.forEach {
    list[$0]! += 1
}

let keys = list.keys.sorted()

print(list)

(0 ..< totalDays).forEach { _ in
    var newGeneration = 0

    (0 ..< maxDaysToSpawn).forEach {
        if $0 == .zero {
            newGeneration = list[$0]!
        }
        
        list[$0]! = list[$0 + 1]!
        
        if $0 == 6 {
            list[6]! = list[6]! + newGeneration
        }
    }

    newGeneration
    list[maxDaysToSpawn] = newGeneration
}

// ANSWER:
print(list.values.reduce(0, +))
