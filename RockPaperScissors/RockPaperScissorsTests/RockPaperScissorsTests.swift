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
    
    /*
     사용자와 컴퓨터의 가위 바위 보 게임입니다
        사용자가 패를 선택하면 컴퓨터의 패는 임의의 패로 지정됩니다
        현재 승/무/패 기록은 화면 중앙에 표시합니다
        승/무/패 기록은 사용자 기준 승/무/패를 나타냅니다
        삼세판 선승제로, 세 판을 먼저 이기는 쪽이 승리합니다
        어느 한 쪽이 최종 승리하면 얼럿을 통해 승자를 표시하고 게임을 초기화합니다
     */
    
    /*
     양쪽이 낸 패의 승패 판결을 위한 기능을 TDD로 구현합니다
     해당 타입, 메서드를 구현해가며 지속적으로 리팩터링 합니다
        삼세판을 이기면 승리하는 기능을 TDD로 구현합니다
        삼세판이 끝나고 승패가 갈리면 초기화 하는 기능을 TDD로 구현합니다
     성능에 유리한 코드로 작성하도록 노력합니다
     기획의 변경에 대해서 최대한 열린 코드로 작성해봅니다
     */
    
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
        XCTAssertNil(user.isWinner)
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
        XCTAssertNil(user.isWinner)
    }
    
    func test_세판_먼저_이기는_쪽이_승리합니다() {
        //given
        let user = User()
        user.win()
        user.win()
        user.win()
        
        //when
        //then
        XCTAssertTrue(user.isWinner!)
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
