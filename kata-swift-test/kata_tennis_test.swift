import XCTest

enum Player : String {
    case A = "A"
    case B = "B"
}

protocol ScoreState {
    func pointFor(player: Player, game: Tennis)
    func getScore() -> String
}

class NormalScoreState : ScoreState {
    let scoreWords = [0: "Love", 1: "Fifteen", 2: "Thirty", 3: "Forty"]
    
    var score = [Player.A : 0, Player.B : 0]
    
    func pointFor(player: Player, game: Tennis) {
        score[player] = score[player]! + 1
        
        if _isDeuce() {
            game.setScoreState(DeuceScoreState())
        } else if (_wins(Player.A)) { //No getValues(...) for enum...
            game.setScoreState(WinScoreState(player: Player.A))
        } else if (_wins(Player.B)) {
            game.setScoreState(WinScoreState(player: Player.B))
        }
    }
    
    func _wins(player: Player) -> Bool {
        return score[player] == 4
    }
    
    func _isDeuce() -> Bool {
        return score[Player.A] == 3 && score[Player.B] == 3
    }
    
    func getScore() -> String {
        return "\(scoreWords[score[Player.A]!]) - \(scoreWords[score[Player.B]!])"
    }
}

class DeuceScoreState : ScoreState {
    func pointFor(player: Player, game: Tennis) { game.setScoreState(AdvantageScoreState(player: player)) }
    
    func getScore() -> String {
        return "Deuce"
    }
}

class AdvantageScoreState : ScoreState {
    var playerOnAdvantage: Player
    
    init(player:Player) { self.playerOnAdvantage = player; }
    
    func pointFor(player: Player, game: Tennis) {
        if player == playerOnAdvantage {
           game.setScoreState(WinScoreState(player: player))
        } else {
           game.setScoreState(DeuceScoreState())
        }
    }
    
    func getScore() -> String {
        return "Advantage " + playerOnAdvantage.toRaw()
    }
}

class WinScoreState: ScoreState {
    var player: Player
    
    init(player:Player) { self.player = player; }
    
    func pointFor(player: Player, game: Tennis) {}
    
    func getScore() -> String {
        return "\(player.toRaw()) Wins"
    }
}

class Tennis {
    var scoreState:ScoreState = NormalScoreState()
    
    func aWins() {
        scoreState.pointFor(Player.A, game: self)
    }
    
    func bWins() {
        scoreState.pointFor(Player.B, game: self)
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
