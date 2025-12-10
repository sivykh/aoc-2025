import Foundation

struct Day10: AdventDay {
    private struct Node: Comparable {
        let state: [Int]
        let g: Int
        let h: Int
        var f: Int {
            g + h
        }

        static func < (lhs: Node, rhs: Node) -> Bool {
            lhs.f < rhs.f
        }

        static func == (lhs: Node, rhs: Node) -> Bool {
            lhs.f == rhs.f && lhs.state == rhs.state
        }
    }

    var data: String

    func part1() -> Any {
        let lines = data.split(whereSeparator: \.isNewline)
        var total = 0

        for line in lines {
            let (diagram, buttons, _) = parseLine(Array(line), masks: true)
            var visited: Set<Int> = [0]
            var queue: [(Int, Int)] = [(0, 0)]

            var i = 0
            while i < queue.count {
                let (state, dist) = queue[i]
                guard state != diagram else {
                    total += dist
                    break
                }

                for b in buttons {
                    let next = state ^ b[0]
                    if !visited.contains(next) {
                        visited.insert(next)
                        queue.append((next, dist + 1))
                    }
                }

                i += 1
            }
        }

        return total
    }

    func part2() -> Any {
        let lines = data.split(whereSeparator: \.isNewline)
        var total = 0
        for (i, line) in lines.enumerated() {
            print(i * 100 / lines.count)
            let (_, buttons, joltage) = parseLine(Array(line), masks: false)
            total += aStar(buttons: buttons, joltage: joltage)
        }

        return total
    }

    private func aStar(buttons: [[Int]], joltage: [Int]) -> Int {
        0
    }

    private func parseLine(_ line: [Character], masks: Bool) -> (Int, [[Int]], [Int]) {
        let parts = separate(line)
        let diagram = parseIndicatorLightDiagram(parts.diagram)
        let buttons = masks ? parts.buttons.map(maskButton) : parts.buttons.map {
            $0.split(separator: ",").compactMap { Int(String($0)) }
        }
        return (
            diagram,
            buttons,
            parts.levels.split(separator: ",").compactMap { Int(String($0)) }
        )
    }

    private func separate(_ line: [Character]) -> (diagram: [Character], buttons: [[Character]], levels: [Character]) {
        let endTargetIndex = line.firstIndex(of: "]")!
        let startLevelsIndex = line.firstIndex(of: "{")!
        let diagram: [Character] = Array(line[(line.firstIndex(of: "[")! + 1)..<endTargetIndex])
        let levels: [Character] = Array(line[(startLevelsIndex + 1)..<line.firstIndex(of: "}")!])
        var buttons: [[Character]] = []

        for i in endTargetIndex..<startLevelsIndex {
            switch line[i] {
            case "(":
                buttons.append([])
            case let x where x.isNumber || x == ",":
                buttons[buttons.count - 1].append(x)
            default:
                break
            }
        }

        return (diagram, buttons, levels)
    }

    private func parseIndicatorLightDiagram(_ s: [Character]) -> Int {
        var mask: Int = 0
        for (i, ch) in s.enumerated() {
            if ch == "#" {
                mask |= (1 << Int(i))
            }
        }
        return mask
    }

    private func maskButton(_ s: [Character]) -> [Int] {
        var mask: Int = 0
        let nums = s.split(separator: ",").compactMap { Int(String($0)) }
        for i in nums {
            mask |= (1 << Int(i))
        }
        return [mask]
    }
}
