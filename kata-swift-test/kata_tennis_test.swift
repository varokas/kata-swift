import XCTest

class Tennis {
    let scoreWords = [0: "Love", 1: "Fifteen", 2: "Thirty", 3: "Forty"]
    
    var scoreA:Int = 0
    var scoreB:Int = 0
    
    func aWins() {
        scoreA++
    }
    
    func bWins() {
        scoreB++
    }
    
    func getScore() -> String {
        if(scoreA == 3 && scoreB == 3) {
            return "Deuce"
        }
        
        return "\(scoreWords[scoreA]) - \(scoreWords[scoreB])"
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
    
    func test_getScore_afterBWinsIs_FifteenLove() {
        letBWins(1)
        XCTAssertEqual(tennis.getScore(), "Love - Fifteen")
    }
    
    func test_getScore_afterBWins2TimesIs_ThirtyLove() {
        letBWins(2)
        XCTAssertEqual(tennis.getScore(), "Love - Thirty")
    }
    
    func test_getScore_afterBWins3TimesIs_FortyLove() {
        letBWins(3)
        XCTAssertEqual(tennis.getScore(), "Love - Forty")
    }
    
    func test_getScore_afterBothWins3Times_Deuce() {
        letAWins(3)
        letBWins(3)
        XCTAssertEqual(tennis.getScore(), "Deuce")
    }
    
    func letAWins(times: Int) {
        for i in 1...times {
            tennis.aWins()
        }
    }
    
    func letBWins(times: Int) {
        for i in 1...times {
            tennis.bWins()
        }
    }

}
