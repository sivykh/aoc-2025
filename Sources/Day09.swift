import Algorithms
import Collections

struct Day09: AdventDay {
    var data: String
    
    var entities: [[Int]] {
        data.split(separator: "\n").map {
            $0.split(separator: ",").compactMap { Int($0) }
        }
    }
    
    func part1() -> Any {
        let red = entities
        var res = 0
        for i in 0..<red.count {
            for j in (i + 1)..<red.count {
                let r1 = red[i]
                let r2 = red[j]
                res = max(res, (abs(r1[0] - r2[0]) + 1) * (abs(r1[1] - r2[1]) + 1))
            }
        }
        return res
    }

    private func reducedRed() -> (red: [[Int]], xMap: [Int], yMap: [Int]) {
        let input = entities
        let xset = Set(input.map { $0[0] }).sorted()
        let yset = Set(input.map { $0[1] }).sorted()

        var xMap = [Int](repeating: 0, count: xset.count + 1)
        var yMap = [Int](repeating: 0, count: yset.count + 1)
        var rxMap = [Int: Int]()
        var ryMap = [Int: Int]()

        for (i, x) in xset.enumerated() {
            xMap[i + 1] = x
            rxMap[x] = i + 1
        }

        for (i, y) in yset.enumerated() {
            yMap[i + 1] = y
            ryMap[y] = i + 1
        }

        return (
            input.map({ [rxMap[$0[0]]!, ryMap[$0[1]]!] }),
            xMap, yMap
        )
    }

    func part2() -> Any {
        let (red, xMap, yMap) = reducedRed()

        let (horizontalRanges, verticalRanges) = {
            var horizontalRanges: [Int: [(i: Int, r: ClosedRange<Int>)]] = [:]
            var verticalRanges: [Int: [(i: Int, r: ClosedRange<Int>)]] = [:]

            for i in 0..<red.count {
                let current = red[i]
                let next = red[(i + 1) % red.count]

                let x1 = current[0], y1 = current[1]
                let x2 = next[0], y2 = next[1]

                if x1 == x2 {
                    let yRange = min(y1, y2)...max(y1, y2)
                    verticalRanges[x1, default: []].append((i, yRange))
                } else if y1 == y2 {
                    let xRange = min(x1, x2)...max(x1, x2)
                    horizontalRanges[y1, default: []].append((i, xRange))
                }
            }
            return (horizontalRanges, verticalRanges)
        }()

        var mem: [[Int]: Bool] = [:]
        func rayCheck(point: [Int]) -> Bool {
            if let cached = mem[point] {
                return cached
            }
            guard horizontalRanges[point[0], default: []].contains(where: { $0.r.contains(point[1]) }) == false,
                  verticalRanges[point[1], default: []].contains(where: { $0.r.contains(point[0]) }) == false else {
                mem[point] = true
                return true
            }

            let followingRayRanges = horizontalRanges[point[0], default: []]
            var cur = point[1]

            var intersectionCount = 0
            while cur > 0 {
                if let first = followingRayRanges.first(where: { $0.r.contains(cur) }) {
                    var prev = first.i
                    while red[prev][1] == red[first.i][1] {
                        prev = (prev + red.count - 1) % red.count
                    }
                    var next = first.i
                    while red[next][1] == red[first.i][1] {
                        next = (next + 1) % red.count
                    }

                    if (red[prev][1] - point[0]) * (red[next][1] - point[0]) < 0 {
                        intersectionCount += 1
                    }
                    cur = first.r.lowerBound
                } else if verticalRanges[cur, default: []].contains(where: { $0.r.contains(point[0]) }) {
                    intersectionCount += 1
                }
                cur -= 1
            }
            mem[point] = intersectionCount % 2 == 1
            return intersectionCount % 2 == 1
        }

        var res = 0
        for i in 0..<red.count {
            for j in (i + 1)..<red.count {
                let x1 = red[i][0], y1 = red[i][1]
                let x2 = red[j][0], y2 = red[j][1]
                let corners = [[x1, y1], [x1, y2], [x2, y1], [x2, y2]]
                var good = true

                for k in 0..<4 where good {
                    let current = corners[k]
                    let next = corners[(k + 1) % 4]
                    let x1 = current[0], y1 = current[1]
                    let x2 = next[0], y2 = next[1]

                    for x in min(x1,x2)...max(x1,x2) where good {
                        for y in min(y1,y2)...max(y1,y2) where good {
                            good = rayCheck(point: [y, x])
                        }
                    }
                }
                if good {
                    res = max(res, (abs(xMap[x1] - xMap[x2]) + 1) * (abs(yMap[y1] - yMap[y2]) + 1))
                }
            }
        }
        return res
    }
}
