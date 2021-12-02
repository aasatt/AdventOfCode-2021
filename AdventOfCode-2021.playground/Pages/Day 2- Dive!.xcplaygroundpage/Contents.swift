//: [Previous](@previous)

import Foundation

guard let file = Bundle.main.url(forResource: "input", withExtension: "txt") else {
    preconditionFailure("Input file not found")
}

let input = try String(contentsOf: file, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)

struct Command {
    enum Direction: String {
        case forward
        case down
        case up
    }

    let direction: Direction
    let distance: Int
}

// Parse commands from text
let commands: [Command] = input.components(separatedBy: .newlines).map {
    let commandString = $0.components(separatedBy: .whitespaces)

    guard let directionString = commandString.first,
          let direction = Command.Direction(rawValue: directionString)
    else {
        preconditionFailure("Invalid direction: \(commandString)")
    }

    guard let distanceString = commandString.last,
          let distance = Int(distanceString)
    else {
        preconditionFailure("Invalid distance: \(commandString)")
    }

    return Command(direction: direction, distance: distance)
}

// MARK: Part 1

func part1(commands: [Command]) -> Int {
    var depth = Int.zero
    var position = Int.zero

    commands.forEach {
        switch $0.direction {
        case .forward:
            position += $0.distance

        case .down:
            depth += $0.distance

        case .up:
            depth -= $0.distance

        }
    }

    return depth * position
}

// Answer:
part1(commands: commands)

// MARK: Part 2

func part2(commands: [Command]) -> Int {
    var depth = Int.zero
    var position = Int.zero
    var aim = Int.zero

    commands.forEach {
        switch $0.direction {
        case .forward:
            position += $0.distance
            depth += aim * $0.distance

        case .down:
            aim += $0.distance

        case .up:
            aim -= $0.distance

        }
    }

    return depth * position
}

// Answer:
part2(commands: commands)
//: [Next](@next)
