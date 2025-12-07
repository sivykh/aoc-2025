import Algorithms
import Collections

struct Day07: AdventDay {
    enum Cell: Character {
        case beam = "S"
        case empty = "."
        case splitter = "^"
    }

    var data: String
    
    var entities: [[Cell]] {
        data.split(separator: "\n").map {
            $0.compactMap { Cell(rawValue: $0) }
        }
    }
    
    func part1() -> Any {
        let input = entities
        let n = input[0].count
        var res = 0
        var beams = Set(input[0].enumerated().compactMap({ $0.element == .beam ? $0.offset : nil }))
        for i in 1..<input.count {
            let splitters = Set(input[i].enumerated().compactMap({ $0.element == .splitter ? $0.offset : nil }))
            let intersection = splitters.intersection(beams)
            res += intersection.count
            let splittedBeams = intersection.flatMap({ [$0 - 1, $0 + 1].filter { 0..<n ~= $0 } })
            beams.subtract(intersection)
            beams.formUnion(splittedBeams)
        }
        return res
    }
    
    func part2() -> Any {
        let input = entities
        let n = input[0].count

        var memo = [[Int]: Int]()
        func dfs(beam: Int, level: Int) -> Int {
            guard level < input.count else {
                return 1
            }
            if let cached = memo[[beam, level]] {
                return cached
            }
            var result = 0
            if input[level][beam] == .splitter {
                for nextBeam in [beam - 1, beam + 1].filter({ 0..<n ~= $0 }) {
                    result += dfs(beam: nextBeam, level: level + 1)
                }
            } else {
                result += dfs(beam: beam, level: level + 1)
            }
            memo[[beam, level]] = result
            return result
        }

        return dfs(beam: input[0].enumerated().compactMap({ $0.element == .beam ? $0.offset : nil })[0], level: 1)
    }
}
