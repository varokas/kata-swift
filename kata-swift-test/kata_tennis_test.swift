import XCTest

protocol ScoreState {
    func aWins(game: Tennis)
    func bWins(game: Tennis)
    
    func getScore() -> String
}

class NormalScoreState : ScoreState {
    let scoreWords = [0: "Love", 1: "Fifteen", 2: "Thirty", 3: "Forty"]
    
    var score:(a: Int, b: Int) = (0, 0)
    
    func aWins(game: Tennis) {
        score.a++
        
        if(_isDeuce()) {
            game.setScoreState(DeuceScoreState())
        } else if(score.a == 4) {
            game.setScoreState(WinScoreState(player: "A"))
        }
    }
    
    func bWins(game: Tennis) {
        score.b++
        
        if(_isDeuce()) {
            game.setScoreState(DeuceScoreState())
        } else if(score.b == 4) {
            game.setScoreState(WinScoreState(player: "B"))
        }
    }
    
    func _isDeuce() -> Bool {
        return score.a == 3 && score.b == 3
    }
    
    func getScore() -> String {
        return "\(scoreWords[score.a]) - \(scoreWords[score.b])"
    }
}

class DeuceScoreState : ScoreState {
    func aWins(game: Tennis) { game.setScoreState(AdvantageAScoreState()) }
    func bWins(game: Tennis) { game.setScoreState(AdvantageBScoreState()) }
    
    func getScore() -> String {
        return "Deuce"
    }
}

class AdvantageAScoreState : ScoreState {
    func aWins(game: Tennis) { game.setScoreState(WinScoreState(player: "A")) }
    func bWins(game: Tennis) { game.setScoreState(DeuceScoreState()) }
    
    func getScore() -> String {
        return "Advantage A"
    }
}

class AdvantageBScoreState : ScoreState {
    func aWins(game: Tennis) { game.setScoreState(DeuceScoreState()) }
    func bWins(game: Tennis) { game.setScoreState(WinScoreState(player: "B")) }
    
    func getScore() -> String {
        return "Advantage B"
    }
}

class WinScoreState: ScoreState {
    var player: String
    
    init(player:String) { self.player = player }
    
    func aWins(game: Tennis) {}
    func bWins(game: Tennis) {}
    
    func getScore() -> String {
        return "\(player) Wins"
    }
}



class Tennis {
    var scoreState:ScoreState = NormalScoreState()
    
    func aWins() {
        scoreState.aWins(self)
    }
    
    func bWins() {
        scoreState.bWins(self)
    }

    func getScore() -> String {
        return scoreState.getScore()
    }
    
    func setScoreState(_scoreState: ScoreState) {
        scoreState = _scoreState
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
