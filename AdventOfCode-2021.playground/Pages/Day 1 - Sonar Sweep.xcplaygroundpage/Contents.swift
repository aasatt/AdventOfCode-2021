//: [Previous](@previous)

import Foundation

// MARK: - Day 1

guard let file = Bundle.main.url(forResource: "input", withExtension: "txt") else {
    preconditionFailure("Input file not found")
}

let input = try String(contentsOf: file, encoding: .utf8)

let values = input.components(separatedBy: .newlines).compactMap { Int($0) }

func getIncreases(values: [Int]) -> [Int] {
    return values.enumerated().compactMap {
        guard $0.offset > .zero else {
            return nil
        }

        return $0.element > values[$0.offset - 1] ? $0.element : nil
    }
}

// MARK: Part 1

// Answer:
getIncreases(values: values).count

// MARK: Part 2

let windowSums = values[.zero ..< values.count-2].enumerated().map {
    return [$0.element, values[$0.offset + 1], values[$0.offset + 2]].reduce(0, +)
}

// Answer:
getIncreases(values: windowSums).count
