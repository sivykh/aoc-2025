//
//  UnionFind.swift
//  AdventOfCode
//
//  Created by Mikhail Sivykh on 08.12.2025.
//

struct UnionFind {
    private var representers: [Int]
    private var rank: [Int]

    init(size: Int) {
        self.representers = Array(0..<size)
        self.rank = Array(repeating: 0, count: size)
    }

    mutating func find(_ x: Int) -> Int {
        guard representers[x] != x else {
            return x
        }
        let rx = find(representers[x])
        representers[x] = rx
        return rx
    }

    mutating func count() -> Int {
        for i in 0..<representers.count {
            _ = find(i)
        }
        return Set(representers).count
    }

    mutating func powers() -> [Int: Int] {
        for i in 0..<representers.count {
            _ = find(i)
        }
        return representers.reduce(into: [Int: Int]()) { $0[$1, default: 0] += 1 }
    }

    @discardableResult
    mutating func join(_ x1: Int, and x2: Int) -> Bool {
        let r1 = find(x1)
        let r2 = find(x2)

        guard r1 != r2 else { return false }

        let value = rank[r1] > rank[r2] ? r1 : r2
        representers[r1] = value
        representers[r2] = value
        representers[x1] = value
        representers[x2] = value

        if rank[r1] == rank[r2] {
            rank[r2] += 1
        }
        return true
    }

    mutating func areConnected(_ x1: Int, _ x2: Int) -> Bool {
        let r1 = find(x1)
        let r2 = find(x2)
        return r1 == r2
    }
}

