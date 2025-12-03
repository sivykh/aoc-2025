import Algorithms
import Collections

struct Day03: AdventDay {
    struct Item: Comparable {
        let n: Int
        let i: Int

        static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.n == rhs.n ? lhs.i > rhs.i : lhs.n < rhs.n
        }
    }

    var data: String
    
    var entities: [[Int]] {
        data.split(separator: "\n").map {
            $0.compactMap { Int(String($0)) }
        }
    }
    
    func part1() -> Any {
        common(number: 2)
    }

    func part2() -> Any {
        common(number: 12)
    }

    private func common(number: Int) -> Int {
        guard number > 0 else {
            return 0
        }

        var res = 0
        for bank in entities {
            let count = bank.count
            var heap = Heap(bank[0..<(count - number)].enumerated().map { Item(n: $0.element, i: $0.offset) })

            var joltage = 0
            var last = -1
            for degree in (1...number).reversed() {
                heap.insert(Item(n: bank[count - degree], i: count - degree))
                while let item = heap.popMax() {
                    if item.i > last {
                        last = item.i
                        joltage = 10 * joltage + item.n
                        break
                    }
                }
            }
            res += joltage
        }
        return res
    }
}
