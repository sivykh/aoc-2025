import Algorithms
import Collections

struct Day05: AdventDay {
    struct Entity {
        let ranges: [ClosedRange<Int>]
        let ingredients: [Int]
    }

    var data: String
    
    var entities: Entity {
        let splitted = data.split(separator: "\n\n")

        let inputRanges = splitted[0]
            .split(separator: "\n")
            .map { String($0).split(separator: "-") }
            .map { Int($0[0])!...Int($0[1])! }

        var ranges = [ClosedRange<Int>]()
        for range in inputRanges {
            var toAdd = range
            var toMergeIndices = Set<Int>()
            for i in 0..<ranges.count {
                if toAdd.lowerBound <= ranges[i].upperBound && toAdd.upperBound >= ranges[i].lowerBound {
                    toAdd = min(toAdd.lowerBound, ranges[i].lowerBound)...max(toAdd.upperBound, ranges[i].upperBound)
                    toMergeIndices.insert(i)
                }
            }
            ranges = ranges.enumerated()
                .filter({ !toMergeIndices.contains($0.offset) })
                .map({ $0.element })
                + [toAdd]
        }

        let ingredients = splitted[1].split(separator: "\n").compactMap { Int($0) }
        return Entity(ranges: ranges, ingredients: ingredients)
    }
    
    func part1() -> Any {
        let input = entities
        return input.ingredients.reduce(0) { res, i in
            res + (input.ranges.contains(where: { $0 ~= i }) ? 1 : 0)
        }
    }
    
    func part2() -> Any {
        entities.ranges.reduce(0) { $0 + $1.upperBound - $1.lowerBound + 1 }
    }
}
