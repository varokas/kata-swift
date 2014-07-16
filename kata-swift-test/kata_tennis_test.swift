import XCTest

class Tennis {
    let scoreWords = [0: "Love", 1: "Fifteen", 2: "Thirty", 3: "Forty"]
    
    var scoreA:Int = 0
    var scoreB:Int = 0
    
    func aWins() {
        if(_isAdvantageB()) {
            _setScoreToDeuce()
        } else {
            scoreA++
        }
    }
    
    func bWins() {
        if(_isAdvantageA()) {
            _setScoreToDeuce()
        } else {
            scoreB++
        }
    }
    
    func _isDeuce() -> Bool {
        return scoreA == 3 && scoreB == 3
    }
    
    func _isAdvantageA() -> Bool {
        return scoreA == 4 && scoreB == 3
    }
    
    func _isAdvantageB() -> Bool {
        return scoreA == 3 && scoreB == 4
    }
    
    func _setScoreToDeuce() {
        scoreA = 3
        scoreB = 3
    }
    
    func getScore() -> String {
        if(_isDeuce()) {
            return "Deuce"
        } else if(_isAdvantageA()) {
            return "Advantage A"
        } else if(_isAdvantageB()) {
            return "Advantage B"
        } else if(scoreA == 5 || (scoreA == 4 && scoreB < 3)) {
            return "A Wins"
        } else if(scoreB == 5 || (scoreB == 4 && scoreA < 3)) {
            return "B Wins"
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
        _letAWins(1)
        XCTAssertEqual(tennis.getScore(), "Fifteen - Love")
    }
    
    func test_getScore_afterAWins2TimesIs_ThirtyLove() {
        _letAWins(2)
        XCTAssertEqual(tennis.getScore(), "Thirty - Love")
    }
    
    func test_getScore_afterAWins3TimesIs_FortyLove() {
        _letAWins(3)
        XCTAssertEqual(tennis.getScore(), "Forty - Love")
    }
    
    func test_getScore_afterAWins4Times_AWins() {
        _letAWins(4)
        XCTAssertEqual(tennis.getScore(), "A Wins")
    }
    
    func test_getScore_afterBWinsIs_FifteenLove() {
        _letBWins(1)
        XCTAssertEqual(tennis.getScore(), "Love - Fifteen")
    }
    
    func test_getScore_afterBWins2TimesIs_ThirtyLove() {
        _letBWins(2)
        XCTAssertEqual(tennis.getScore(), "Love - Thirty")
    }
    
    func test_getScore_afterBWins3TimesIs_FortyLove() {
        _letBWins(3)
        XCTAssertEqual(tennis.getScore(), "Love - Forty")
    }
    
    func test_getScore_afterBWins4Times_BWins() {
        _letBWins(4)
        XCTAssertEqual(tennis.getScore(), "B Wins")
    }
    
    func test_getScore_afterBothWins3Times_Deuce() {
        _letAWins(3)
        _letBWins(3)
        XCTAssertEqual(tennis.getScore(), "Deuce")
    }
    
    func test_getScore_aWinsAfterDeuce_AdvantageA() {
        _letAWins(3)
        _letBWins(3)
        _letAWins(1)
        XCTAssertEqual(tennis.getScore(), "Advantage A")
    }
    
    func test_getScore_bWinsAfterDeuceIs_AdvantageB() {
        _letAWins(3)
        _letBWins(3)
        _letBWins(1)
        XCTAssertEqual(tennis.getScore(), "Advantage B")
    }
    
    func test_getScore_aLooseAdvantage_backtoDeuce() {
        _letAWins(3)
        _letBWins(3)
        _letAWins(1)
        _letBWins(1)
        XCTAssertEqual(tennis.getScore(), "Deuce")
    }
    
    func test_getScore_bLooseAdvantage_backtoDeuce() {
        _letAWins(3)
        _letBWins(3)
        _letBWins(1)
        _letAWins(1)
        XCTAssertEqual(tennis.getScore(), "Deuce")
    }
    
    func test_getScore_aWins2TimesAfterDuece_WinsTheGame() {
        _letAWins(3)
        _letBWins(3)
        _letAWins(2)
        XCTAssertEqual(tennis.getScore(), "A Wins")
    }
    
    func test_getScore_bWins2TimesAfterDuece_WinsTheGame() {
        _letAWins(3)
        _letBWins(3)
        _letBWins(2)
        XCTAssertEqual(tennis.getScore(), "B Wins")
    }
    
    func _letAWins(times: Int) {
        for i in 1...times {
            tennis.aWins()
        }
    }
    
    func _letBWins(times: Int) {
        for i in 1...times {
            tennis.bWins()
        }
    }

}
