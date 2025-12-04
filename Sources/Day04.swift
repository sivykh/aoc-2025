import Algorithms
import Collections

struct Day04: AdventDay {
    enum Cell: Character {
        case empty = "."
        case paper = "@"
    }

    private let moves = [
        [-1, -1], [-1, 0], [-1, 1],
        [0, -1], [0, 1],
        [1, -1], [1, 0], [1, 1]
    ]

    var data: String
    
    var entities: [[Cell]] {
        data.split(separator: "\n").map {
            $0.compactMap { Cell(rawValue: $0) }
        }
    }
    
    func part1() -> Any {
        accessedByForkliftPapers(in: entities).count
    }
    
    func part2() -> Any {
        var input = entities

        var res = 0
        while true {
            let accessed = accessedByForkliftPapers(in: input)
            res += accessed.count
            for item in accessed {
                input[item[0]][item[1]] = .empty
            }
            if accessed.isEmpty {
                break
            }
        }
        return res
    }

    private func accessedByForkliftPapers(in input: [[Cell]]) -> [[Int]] {
        var res = [[Int]]()
        for row in 0..<input.count {
            for col in 0..<input[row].count where input[row][col] == .paper {
                var count = 0
                for move in moves where 0..<input.count ~= move[0] + row && 0..<input[row].count ~= move[1] + col {
                    count += input[move[0] + row][move[1] + col] == .paper ? 1 : 0
                }
                if count < 4 {
                    res.append([row, col])
                }
            }
        }
        return res
    }
}
