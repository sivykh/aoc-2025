import Algorithms
import Collections

struct Day06: AdventDay {
    struct Entity {
        enum Operation: Character {
            case add = "+"
            case multy = "*"
        }
        let operation: Operation
        let numbers: [Int]

        func calc() -> Int {
            numbers.reduce(operation == .add ? 0 : 1, { operation == .add ? ($0 + $1) : ($0 * $1) })
        }
    }
    var data: String

    var entities: [Entity] {
        let lines = data.split(separator: "\n")
        var numbers = [[Int]]()
        for i in 0..<(lines.count - 1) {
            let line = lines[i]
            let nums = line.split(separator: " ").compactMap({ Int(String($0)) })
            for j in 0..<nums.count {
                if i == 0 {
                    numbers.append([])
                }
                numbers[j].append(nums[j])
            }
        }
        let operations = lines.last!
            .split(separator: " ")
            .compactMap({ $0.first.flatMap { Entity.Operation(rawValue: $0) } })
        var res = [Entity]()
        for i in 0..<numbers.count {
            res.append(Entity(operation: operations[i], numbers: numbers[i]))
        }
        return res
    }

    var entities2: [Entity] {
        let lines = data.split(separator: "\n").map(Array.init)
        let count = lines[0].count
        var spaces = Set(0..<count)
        for i in 0..<lines.count {
            for j in 0..<count where lines[i][j] != " " {
                spaces.remove(j)
            }
        }

        var numbers = [[Int]]()
        let cols = [-1] + spaces.sorted() + [count]
        for c in 1..<cols.count {
            var nums = [Int]()
            for j in stride(from: cols[c] - 1, to: cols[c - 1], by: -1) {
                var n = 0
                for i in 0..<(lines.count - 1) where lines[i][j].isNumber {
                    n = 10 * n + Int(String(lines[i][j]))!
                }
                nums.append(n)
            }
            numbers.append(nums)
        }
        let operations = lines.last!
            .split(separator: " ")
            .compactMap({ $0.first.flatMap { Entity.Operation(rawValue: $0) } })
        var res = [Entity]()
        for i in 0..<numbers.count {
            res.append(Entity(operation: operations[i], numbers: numbers[i]))
        }
        return res
    }

    
    func part1() -> Any {
        entities.reduce(0, { $0 + $1.calc() })
    }
    
    func part2() -> Any {
        entities2.reduce(0, { $0 + $1.calc() })
    }
}
