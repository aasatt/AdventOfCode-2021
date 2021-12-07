//: [Previous](@previous)

import Foundation

guard let file = Bundle.main.url(forResource: "input", withExtension: "txt") else {
    preconditionFailure("Input file not found")
}

let inputString = try String(contentsOf: file, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)

var input = inputString.components(separatedBy: .punctuationCharacters).map { Int($0)! }

// MARK: - Part 1

var minFuelPart1 = Int.max

(0 ..< input.count).forEach { position in
    let fuel = Int(input.map {
        return (position - $0).magnitude
    }.reduce(0, +))

    minFuelPart1 = min(minFuelPart1, fuel)
}

// Answer:
minFuelPart1

// MARK: - Part 2

var minFuelPart2 = Int.max

(0 ..< input.count).forEach { position in
    let fuel = Int(input.map {
        let distance = (position - $0).magnitude
        return Int((distance * (distance + 1)) / 2)
    }.reduce(0, +))

    minFuelPart2 = min(minFuelPart2, fuel)
}

// Answer:
minFuelPart2
