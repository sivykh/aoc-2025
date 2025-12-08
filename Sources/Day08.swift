import Algorithms
import Collections
import Foundation

struct Day08: AdventDay {
    struct Point {
        let x: Int, y: Int, z: Int

        func dist(to p: Point) -> Double {
            sqrt(Double((x - p.x)*(x - p.x) + (y - p.y)*(y - p.y) + (z - p.z)*(z - p.z)))
        }
    }
    struct Edge: Comparable {
        static func < (lhs: Day08.Edge, rhs: Day08.Edge) -> Bool {
            lhs.len < rhs.len
        }
        
        let i1: Int, i2: Int
        let len: Double
    }

    var data: String
    
    var entities: [Point] {
        data.split(separator: "\n").compactMap {
            let a = $0.split(separator: ",").compactMap { Int($0) }
            return Point(x: a[0], y: a[1], z: a[2])
        }
    }
    
    func part1() -> Any {
        let input = entities
        let isTest = input.count <= 20
        let steps = isTest ? 10 : 1000

        var heap = Heap<Edge>()
        for i in 0..<input.count {
            for j in (i + 1)..<input.count {
                heap.insert(Edge(i1: i, i2: j, len: input[i].dist(to: input[j])))
            }
        }

        var uf = UnionFind(size: input.count)

        for _ in 0..<steps {
            if let edge = heap.popMin() {
                uf.join(edge.i1, and: edge.i2)
            }
        }

        let sorted = uf.powers().sorted(by: { $0.value > $1.value })

        return sorted[0...2].reduce(1) { $0 * $1.value }
    }
    
    func part2() -> Any {
        let input = entities

        var heap = Heap<Edge>()
        for i in 0..<input.count {
            for j in (i + 1)..<input.count {
                heap.insert(Edge(i1: i, i2: j, len: input[i].dist(to: input[j])))
            }
        }

        var uf = UnionFind(size: input.count)
        var lastEdge: Edge!

        while uf.count() > 1 {
            if let edge = heap.popMin() {
                uf.join(edge.i1, and: edge.i2)
                lastEdge = edge
            }
        }

        return input[lastEdge!.i1].x * input[lastEdge!.i2].x
    }
}
