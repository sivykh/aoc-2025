import Foundation

struct Day10: AdventDay {
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
        for line in lines {
            let (_, buttons, joltage) = parseLine(Array(line), masks: false)
            var solution = gauss(buttons: buttons, joltage: joltage)
            if solution == -1 {
                solution = anotherSolver(buttons: buttons, joltage: joltage)
            }
            total += solution
        }
        return total
    }
    
    private func anotherSolver(buttons: [[Int]], joltage: [Int]) -> Int {
        0
    }

    private func gauss(buttons: [[Int]], joltage: [Int]) -> Int {
        let n = joltage.count
        let m = buttons.count
        
        var matrix = Array(repeating: Array(repeating: 0.0, count: m + 1), count: n)
        
        for i in 0..<n {
            for j in 0..<m {
                if buttons[j].contains(i) {
                    matrix[i][j] = 1.0
                }
            }
            matrix[i][m] = Double(joltage[i])
        }
        
        var currentRow = 0
        for col in 0..<m {
            guard let pivotRow = (currentRow..<n).first(where: { matrix[$0][col] != 0 }) else {
                continue
            }
            
            if pivotRow != currentRow {
                matrix.swapAt(currentRow, pivotRow)
            }

            for row in (currentRow + 1)..<n {
                if matrix[row][col] != 0 {
                    let factor = matrix[row][col] / matrix[currentRow][col]
                    for j in col...(m) {
                        matrix[row][j] -= factor * matrix[currentRow][j]
                    }
                }
            }
            
            currentRow += 1
        }
        
        var solution = Array(repeating: 0.0, count: m)
        
        for i in stride(from: min(currentRow, n) - 1, through: 0, by: -1) {
            guard let leadCol = (0..<m).first(where: { matrix[i][$0] != 0 }) else {
                continue
            }
            
            var sum = matrix[i][m]
            for j in (leadCol + 1)..<m {
                sum -= matrix[i][j] * solution[j]
            }
            solution[leadCol] = sum / matrix[i][leadCol]
        }
        
        if solution.contains(where: { floor($0) != ceil($0) || $0 < 0 }) {
            return -1
        }
        return Int(solution.reduce(0) { $0 + Int($1) })
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
