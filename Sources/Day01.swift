import Algorithms
import Collections

struct Day01: AdventDay {
    enum Direction: Character {
        case left = "L"
        case right = "R"
    }
    struct Move {
        let direction: Direction
        let distance: Int

        init?(chars: [Character]) {
            if let direction = Direction(rawValue: chars[0]) {
                self.direction = direction
            } else {
                return nil
            }
            if let count = Int(String(chars[1...])) {
                self.distance = count
            } else {
                return nil
            }
        }
    }

    var data: String
    
    var entities: [Move] {
        data.split(separator: "\n").compactMap { Move(chars: Array($0)) }
    }
    
    func part1() -> Any {
        var res = 0
        var point = 50
        for move in entities {
            let f = move.direction == .left ? -1 : 1
            point = (point + f * move.distance) % 100
            res += point == 0 ? 1 : 0
        }
        return res
    }
    
    func part2() -> Any {
        var point = 50
        var res = 0

        for move in entities {
            let f = (move.direction == .left) ? -1 : 1

            var firstExpected = f > 0 ? 100 - point : point
            firstExpected = firstExpected == 0 ? 100 : firstExpected
            if move.distance >= firstExpected {
                res += 1 + (move.distance - firstExpected) / 100
            }
            point = (100 + point + f * (move.distance % 100)) % 100
        }

        return res
    }
}
