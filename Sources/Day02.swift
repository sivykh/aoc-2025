import Foundation

struct Day02: AdventDay {
    var data: String

    var entities: [[Int]] {
        data
            .split(whereSeparator: \.isNewline)
            .flatMap { $0.split(separator: ",") }
            .map { $0.split(separator: "-").compactMap { Int($0) } }
    }

    func part1() -> Any {
        entities.reduce(0) { $0 + solve(for: $1, part1: true) }
    }

    func part2() -> Any {
        entities.reduce(0) { $0 + solve(for: $1, part1: false) }
    }

    private func solve(for range: [Int], part1: Bool) -> Int {
        let lo = range[0]
        let hi = range[1]

        let minLen = digitsCount(lo)
        let maxLen = digitsCount(hi)

        var result = 0
        var seen = Set<Int>()

        for len in minLen...maxLen where (len > 1) && (!part1 || len % 2 == 0) {
            let possibleRange = max(lo, pow10(len - 1))...min(hi, pow10(len) - 1)
            let blockRange: ClosedRange<Int> = (part1 ? (len / 2) : 1)...(len / 2)

            for block in blockRange where len % block == 0 {
                let repeats = len / block

                let lowBase = pow10(block - 1)
                let highBase = pow10(block) - 1

                for base in lowBase...highBase {
                    let num = buildRepeated(base, times: repeats, block: block)
                    if possibleRange ~= num, !seen.contains(num) {
                        seen.insert(num)
                        result += num
                    }
                }
            }
        }

        return result
    }

    private func buildRepeated(_ base: Int, times: Int, block: Int) -> Int {
        var r = 0
        let shift = pow10(block)
        for _ in 0..<times {
            r = r * shift + base
        }
        return r
    }

    private func pow10(_ n: Int) -> Int {
        (0..<n).reduce(1) { val, _ in val * 10 }
    }

    private func digitsCount(_ n: Int) -> Int {
        if n < 10 { return 1 }
        if n < 100 { return 2 }
        if n < 1_000 { return 3 }
        if n < 10_000 { return 4 }
        if n < 100_000 { return 5 }
        if n < 1_000_000 { return 6 }
        if n < 10_000_000 { return 7 }
        if n < 100_000_000 { return 8 }
        if n < 1_000_000_000 { return 9 }
        return Int(log10(Double(n))) + 1
    }
}
