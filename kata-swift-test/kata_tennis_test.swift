import XCTest

class Tennis {
    let scoreWords = [0: "Love", 1: "Fifteen", 2: "Thirty", 3: "Forty"]
    
    var scoreA:Int = 0
    
    func aWins() {
        scoreA++
    }
    
    func getScore() -> String {
        return "\(scoreWords[scoreA]) - Love"
    }
}

class kata_tennis_test: XCTestCase {
    let tennis = Tennis()
    
    func test_getScoreInitiallyIs_LoveLove() {
        XCTAssertEqual(tennis.getScore(), "Love - Love")
    }
    
    func test_getScore_afterAWinsIs_FifteenLove() {
        letAWins(1)
        XCTAssertEqual(tennis.getScore(), "Fifteen - Love")
    }
    
    func test_getScore_afterAWins2TimesIs_ThirtyLove() {
        letAWins(2)
        XCTAssertEqual(tennis.getScore(), "Thirty - Love")
    }
    
    func test_getScore_afterAWins3TimesIs_FortyLove() {
        letAWins(3)
        XCTAssertEqual(tennis.getScore(), "Forty - Love")
    }
    
    func letAWins(times: Int) {
        for i in 1...times {
            tennis.aWins()
        }
    }

}
