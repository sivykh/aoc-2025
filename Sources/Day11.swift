import Algorithms
import Collections
import Foundation

struct Day11: AdventDay {
    var data: String

    var entities: [String: [String]] {
        data.split(separator: "\n").reduce(into: [String: [String]]()) { res, line in
            let splitted = line.split(separator: ":")
            res[String(splitted[0])] = splitted[1]
                .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                .split(separator: " ")
                .map { String($0) }
        }
    }

    func part1() -> Any {
        Day11Solver(input: entities).dfs(node: "you", fft: true, dac: true)
    }

    func part2() -> Any {
        Day11Solver(input: entities).dfs(node: "svr", fft: false, dac: false)
    }
}

class Day11Solver {
    struct CacheNode: Hashable {
        let name: String
        let fft: Bool
        let dac: Bool
    }

    private let input: [String: [String]]
    private var mem = [CacheNode: Int]()

    init(input: [String : [String]], mem: [CacheNode : Int] = [CacheNode: Int]()) {
        self.input = input
        self.mem = mem
    }

    func dfs(node: String, fft: Bool, dac: Bool, ) -> Int {
        guard node != "out" else {
            return fft && dac ? 1 : 0
        }
        let cacheNode = CacheNode(name: node, fft: fft, dac: dac)
        if let cached = mem[cacheNode] {
            return cached
        }
        var res = 0
        for next in input[node, default: []] {
            res += dfs(node: next, fft: fft || node == "fft", dac: dac || node == "dac")
        }
        mem[cacheNode] = res
        return res
    }
}
