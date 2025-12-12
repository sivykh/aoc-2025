import XCTest
@testable import AdventOfCode

final class Day12Tests: XCTestCase {
    let testData = """
    0:
    ###
    ##.
    ##.

    1:
    ###
    ##.
    .##

    2:
    .##
    ###
    ##.

    3:
    ##.
    ###
    ##.

    4:
    ###
    #..
    ###

    5:
    ###
    .#.
    ###

    4x4: 0 0 0 0 2 0
    12x5: 1 0 1 0 2 2
    12x5: 1 0 1 0 3 2
    """

    func testPart1() throws {
        let challenge = Day12(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "2")
    }

    func testPart2() throws {
        let challenge = Day12(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "0")
    }
}
