//: [Previous](@previous)

import Foundation
import CoreGraphics

guard let file = Bundle.main.url(forResource: "input", withExtension: "txt") else {
    preconditionFailure("Input file not found")
}

// let input = try String(contentsOf: file, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)

let input = """
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
"""

struct Line {
    var begin: CGPoint
    var end: CGPoint
}

let lineValues = input.components(separatedBy: .newlines)

let linesStrings: [[String]] = lineValues.map {
    $0.components(separatedBy: " -> ")
}

let lines: [Line] = linesStrings.compactMap {
    guard let first = $0.first, let last = $0.last else {
        preconditionFailure("Must have begin and end")
    }

    let firstComp = first.components(separatedBy: .punctuationCharacters).map { CGFloat(Int($0)!) }
    let lastComp = last.components(separatedBy: .punctuationCharacters).map { CGFloat(Int($0)!) }

    return Line(begin: CGPoint(
            x: firstComp.first!,
            y: firstComp.last!
        ),
         end: CGPoint(
            x: lastComp.first!,
            y: lastComp.last!
         )
    )
}
