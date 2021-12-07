//: [Previous](@previous)

import Foundation

guard let file = Bundle.main.url(forResource: "input", withExtension: "txt") else {
    preconditionFailure("Input file not found")
}

let inputString = try String(contentsOf: file, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)

var input = inputString.components(separatedBy: .punctuationCharacters).map { Int($0)! }

let totalDays = 80

struct Fish {
    var spawnDays: Int
    var generation: Int

    init(spawnDays: Int) {
        self.generation = .zero
        self.spawnDays = spawnDays
    }

    init(generation: Int) {
        self.generation = generation
        self.spawnDays = 7
    }
}

var totalFish = input.count

let fish = input.map { Fish(spawnDays: $0) }

func calculateOffspring(fish: Fish) -> Int {
    var daysRemaining = totalDays - fish.generation

    guard fish.generation < totalDays else {
        return -1
    }

    guard fish.generation + 7 < totalDays else { return .zero }

    var offspringCount = 0

    if fish.generation == .zero {
        offspringCount += 1
        daysRemaining -= fish.spawnDays
    }

    offspringCount += Int(daysRemaining / 7)

    (0 ..< offspringCount).forEach { i in
        let firstGen = fish.generation == .zero ? fish.spawnDays : fish.generation + 9

        offspringCount += calculateOffspring(fish: Fish(generation: firstGen + (i * 7)))
    }

    return offspringCount
}

fish.forEach {
   totalFish += calculateOffspring(fish: $0)
}

print(totalFish)
