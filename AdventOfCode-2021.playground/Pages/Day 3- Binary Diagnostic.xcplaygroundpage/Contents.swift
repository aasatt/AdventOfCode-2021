//: [Previous](@previous)

import Foundation

guard let file = Bundle.main.url(forResource: "input", withExtension: "txt") else {
    preconditionFailure("Input file not found")
}

let input = try String(contentsOf: file, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)

let lines = input.components(separatedBy: .newlines).map { $0.map { String($0) } }

let bitCount = lines[0].count

// MARK: - PART 1

let gammaArray: [Int] = (0 ..< bitCount).map { bit in
    let bits = lines.map { Int(String($0[bit]))! }

    let countedSet = NSCountedSet(array: bits)

    return countedSet.max(by: { countedSet.count(for: $0) < countedSet.count(for: $1) }) as! Int
}

let gammasString = gammaArray.map { String($0) }.joined()
let epsilonString = gammaArray.map { $0 == .zero ? "1" : "0" }.joined()


let gamma = Int(gammasString, radix: 2)!
let eplison = Int(epsilonString, radix: 2)!

// Answer:
gamma * eplison


// MARK: - PART 2

func mostCommonBit(at index: Int, in source: [[String]]) -> Int {
    let bits = source.map { Int(String($0[index]))! }

    let countedSet = NSCountedSet(array: bits)

    let zeroCount = countedSet.count(for: 0)
    let oneCount = countedSet.count(for: 1)

    return zeroCount > oneCount ? .zero : 1
}


var oxygenGeneratorLines = lines
var scrubberLines = lines

(0 ..< bitCount).forEach { bit in
    let mostCommon = mostCommonBit(at: bit, in: oxygenGeneratorLines)
    let leastCommon = mostCommonBit(at: bit, in: scrubberLines) == .zero ? 1 : .zero

    oxygenGeneratorLines = oxygenGeneratorLines.filter {
        guard oxygenGeneratorLines.count > 1 else {
            return true
        }

        return String($0[bit]) == String(mostCommon)
    }

    scrubberLines = scrubberLines.filter {
        guard scrubberLines.count > 1 else {
            return true
        }

        return String($0[bit]) == String(leastCommon)
    }
}

let oxygen = oxygenGeneratorLines.last!.joined()
let scrubber = scrubberLines.last!.joined()


let oxygenValue = Int(oxygen, radix: 2)!
let scrubberValue = Int(scrubber, radix: 2)!

// Answer:
oxygenValue * scrubberValue
//: [Next](@next)

