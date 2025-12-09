import XCTest
@testable import AdventOfCode

final class Day09Tests: XCTestCase {
    let testData = """
    7,1
    11,1
    11,7
    9,7
    9,5
    2,5
    2,3
    7,3
    """

    func testPart1() throws {
        let challenge = Day09(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "50")
    }

    func testPart2() throws {
        let challenge = Day09(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "24")
    }
}
