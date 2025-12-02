import Foundation

struct Day02: AdventDay {
    var data: String
    
    var entities: [[Int]] {
        Array(data).filter({ $0 != "\n" }).split(separator: ",").map {
            $0.split(separator: "-").compactMap { Int(String($0)) }
        }
    }
    
    func part1() -> Any {
        var res = 0
        for r in entities {
            for i in r[0]...r[1] where isRepeated(i, part1: true) {
                res += i
            }
        }
        return res
    }

    func part2() -> Any {
        var res = 0
        for r in entities {
            for i in r[0]...r[1] where isRepeated(i) {
                res += i
            }
        }
        return res
    }

    private func isRepeated(_ n: Int, part1: Bool = false) -> Bool {
        let digits = digits(n)
        let l = digits.count
        guard l > 1 && (!part1 || l % 2 == 0) else {
            return false
        }
        let range = (part1 ? l/2 : 1)...(l/2)

        for len in range where l % len == 0 && check(slice: digits[0..<len], digits: digits) {
            return true
        }
        return false
    }

    private func check(slice: ArraySlice<Int>, digits: [Int]) -> Bool {
        let count = slice.count
        let loops = digits.count / count
        for i in 0..<loops {
            for j in 0..<count where digits[count * i + j] != slice[j] {
                return false
            }
        }
        return true
    }

    private func digits(_ n: Int) -> [Int] {
        var n = n
        var res = [Int](repeating: 0, count: Int(log10(Double(n))) + 1)
        for i in (0..<res.count).reversed() {
            res[i] = n % 10
            n /= 10
        }
        return res
    }
}
