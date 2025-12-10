import XCTest
@testable import AdventOfCode

final class Day10Tests: XCTestCase {
    let testData = """
    [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
    [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
    [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
    """

    func testPart1() throws {
        let challenge = Day10(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "7")
    }

    func testPart2() throws {
        let challenge = Day10(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "33")
    }
}
