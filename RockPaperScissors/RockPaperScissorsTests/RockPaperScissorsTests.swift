//
//  RockPaperScissorsTests.swift
//  RockPaperScissorsTests
//
//  Created by Jay Song on 4/25/24.
//

import XCTest
@testable import RockPaperScissors

final class RockPaperScissorsTests: XCTestCase {
    
    var sut: GameViewController!
    
    override func setUpWithError() throws {
        sut = GameViewController()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_묵찌빠_한번_이긴이후_비겼을때_승리() {
        //given
        let user = User()
        user.select(card: .paper)
        user.isWinner = true
        
        let computer = Computer()
        computer.select(card: .rock)
        
        //when
        let cal = user.selectedCard!.rawValue - computer.selectedCard!.rawValue

        if cal == 0 {
            user.draw()
            if let isWinner = user.isWinner {
                if isWinner {
                    user.win()
                    return
                }
                if !isWinner {
                    user.lose()
                    return
                }
            }
        }
        if cal < 0 {
            user.isWinner = false
            return
        }
        if cal > 0 {
            user.isWinner = true
            return
        }
        if cal == -2 {
            user.isWinner = true
            return
        }
        if cal == 2 {
            user.isWinner = false
            return
        }
        
        //then
        XCTAssertEqual(user.winCount, 1)
    }
    
    func test_묵찌빠_컴퓨터와_가위바위보단계_이길때() {
        //given
        let user = User()
        user.select(card: .paper)
        
        let computer = Computer()
        computer.select(card: .rock)
        
        //when
        let cal = user.selectedCard!.rawValue - computer.selectedCard!.rawValue

        if cal == 0 {
            user.draw()
            if let isWinner = user.isWinner {
                if isWinner {
                    user.win()
                    return
                }
                if !isWinner {
                    user.lose()
                    return
                }
            }
        }
        if cal < 0 {
            user.isWinner = false
            return
        }
        if cal > 0 {
            user.isWinner = true
            return
        }
        if cal == -2 {
            user.isWinner = true
            return
        }
        if cal == 2 {
            user.isWinner = false
            return
        }
        
        //then
        XCTAssertTrue(user.isWinner!)
    }
    
    func test_묵찌빠_패배한다음_비기면_패배() {
        //given
        let user = User()
        user.lose()
        user.draw()
        
        //when
        //then
        XCTAssertEqual(user.loseCount, 1)
    }
    
    func test_묵찌빠_승리한다음_비기면_승리() {
        //given
        let user = User()
        user.win()
        user.draw()
        
        //when
        //then
        XCTAssertEqual(user.winCount, 1)
    }
    
    func test_승패가_갈리면_초기화합니다_지는경우() {
        //given
        var user = User()
        user.lose()
        user.lose()
        user.lose()
        
        //when
        user = User()
        
        //then
        XCTAssertNil(user.selectedCard)
        XCTAssertEqual(user.winCount, 0)
        XCTAssertEqual(user.drawCount, 0)
        XCTAssertEqual(user.loseCount, 0)
        XCTAssertNil(user.isFinalWinner)
    }
    
    func test_승패가_갈리면_초기화합니다_이기는경우() {
        //given
        var user = User()
        user.win()
        user.win()
        user.win()
        
        //when
        user = User()
        
        //then
        XCTAssertNil(user.selectedCard)
        XCTAssertEqual(user.winCount, 0)
        XCTAssertEqual(user.drawCount, 0)
        XCTAssertEqual(user.loseCount, 0)
        XCTAssertNil(user.isFinalWinner)
    }
    
    func test_세판_먼저_이기는_쪽이_승리합니다() {
        //given
        let user = User()
        user.win()
        user.win()
        user.win()
        
        //when
        //then
        XCTAssertTrue(user.isFinalWinner!)
    }
    
    func test_승무패_기록_표시합니다() {
        //given
        let user = User()
        user.win()
        user.lose()
        user.lose()
        user.draw()
        user.lose()
        user.draw()
        
        //when
        //then
        XCTAssertEqual(user.winCount, 1)
        XCTAssertEqual(user.drawCount, 2)
        XCTAssertEqual(user.loseCount, 3)
    }
    
    func test_사용자가_패를_선택하면_컴퓨터의_패는_임의의_패로_지정됩니다() {
        //given
        let user = User()
        user.select(card: .paper)
        
        //when
        let computer = Computer()
        computer.select(card: .rock)
        
        //then
        XCTAssertNotNil(computer.selectedCard)
    }
}
