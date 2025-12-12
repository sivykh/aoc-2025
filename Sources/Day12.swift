import Algorithms
import Collections

struct Day12: AdventDay {
    var data: String
    
    var entities: (blocks: [Int], grid: [Int], expectations: [Int]) {
        let inputBlocks = data.split(separator: "\n\n").map { Array($0) }
        var blocks = [Int]()
        for j in 0..<(inputBlocks.count - 1) {
            var count = 0
            for i in 1..<inputBlocks[j].count {
                count += inputBlocks[j][i] == "#" ? 1 : 0
            }
            blocks.append(count)
        }
        var grid = [Int]()
        var expectations = [Int]()
        let lines = inputBlocks.last!.split(separator: "\n")
        for line in lines {
            let parts = line.split(separator: ":")
            let square = parts[0].split(separator: "x").compactMap { Int(String($0)) }
            let expectation = parts[1].split(separator: " ").compactMap { Int(String($0)) }
            grid.append(square[0] * square[1])
            expectations.append(expectation.enumerated().reduce(0) { $0 + $1.element * blocks[$1.offset] })
        }
        return (blocks, grid, expectations)
    }
    
    func part1() -> Any {
        let input = entities
        var total = 0
        for i in 0..<input.grid.count where input.expectations[i] <= input.grid[i] {
            total += 1
        }
        return total
    }
    
    func part2() -> Any {
        0
    }
}
