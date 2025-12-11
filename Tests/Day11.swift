import XCTest
@testable import AdventOfCode

final class Day11Tests: XCTestCase {

    func testPart1() throws {
        let testData = """
            aaa: you hhh
            you: bbb ccc
            bbb: ddd eee
            ccc: ddd eee fff
            ddd: ggg
            eee: out
            fff: out
            ggg: out
            hhh: ccc fff iii
            iii: out
            """
        let challenge = Day11(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "5")
    }

    func testPart2() throws {
        let testData = """
            svr: aaa bbb
            aaa: fft
            fft: ccc
            bbb: tty
            tty: ccc
            ccc: ddd eee
            ddd: hub
            hub: fff
            eee: dac
            dac: fff
            fff: ggg hhh
            ggg: out
            hhh: out
            """
        let challenge = Day11(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "2")
    }
}
