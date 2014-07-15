import XCTest

class Tennis {
    func getScore() -> String {
        return "Love - Love"
    }
}

class kata_tennis_test: XCTestCase {
    let tennis = Tennis()
    

    func test_getScoreInitiallyIs_LoveLove() {
        XCTAssertEqual(tennis.getScore(), "Love - Love")
    }

}
