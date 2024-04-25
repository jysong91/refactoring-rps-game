//
//  RockPaperScissors - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class GameViewController: UIViewController {

    private var user: User = User()
    private var computer: Computer = Computer()
    private var gameView: GameView?
    
    override func loadView() {
        gameView = GameView(delegate: self)
        guard let gameView = gameView else { return }
        view = gameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView?.setResultLabel(with: "")
    }
    
    private func play(userCard: Card) {
        let cards: [Card] = Card.allCases
        guard let computerCard = cards.randomElement() else { return }
        user.select(card: userCard)
        computer.select(card: computerCard)
        gameView?.setComputerHand(with: computerCard)
        showResult()
        gameView?.setCurrentWinLoseLabel(win: user.winCount, lose: user.loseCount)
    }
    
    private func showResult() {
        judgement()
        
        if let isUserFinalWinner = user.isFinalWinner {
            showResultAlert(isUserFinalWinner)
            return
        }
    }
    
    private func judgement() {
        guard let userCard = user.selectedCard, let computerCard = computer.selectedCard else { return }
        let cal = userCard.rawValue - computerCard.rawValue

        if cal == 0 {
            if let isWinner = user.isWinner {
                if isWinner {
                    user.win()
                    gameView?.setResultLabel(with: "이겼습니다!")
                }
                if !isWinner {
                    user.lose()
                    gameView?.setResultLabel(with: "졌습니다!")
                }
            }
            user.isWinner = nil
            return
        }
        if cal < 0 {
            user.isWinner = false
        }
        if cal > 0 {
            user.isWinner = true
        }
        if cal == -2 {
            user.isWinner = true
        }
        if cal == 2 {
            user.isWinner = false
        }
        if let isUserWinner = user.isWinner {
            gameView?.setResultLabel(with: isUserWinner ? "묵찌빠 >" : "< 묵찌빠")
        }
    }
    
    private func showResultAlert(_ isUserFinalWinner: Bool) {
        let alertController = UIAlertController(title: nil, message: isUserFinalWinner ? "당신이 이겼습니다!" : "컴퓨터가 이겼습니다!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.resetGame()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func resetGame() {
        user = User()
        computer = Computer()
        gameView?.setResultLabel(with: "")
        gameView?.setComputerHand(with: nil)
        gameView?.setUserHand(with: nil)
        gameView?.setCurrentWinLoseLabel(win: 0, lose: 0)
    }
}

extension GameViewController: GameViewDelegate {
    func selectRock() {
        user.select(card: .rock)
    }
    
    func selectPaper() {
        user.select(card: .paper)
    }
    
    func selectScissors() {
        user.select(card: .scissors)
    }
    
    func resetButton() {
        resetGame()
    }
    
    func playButton() {
        guard let userCard = user.selectedCard else {
            gameView?.setResultLabel(with: "패를 고르세요")
            return
        }
        play(userCard: userCard)
    }
}

protocol Player: AnyObject {
    var selectedCard: Card? { get }

    func select(card: Card)
}

class Computer: Player {
    var selectedCard: Card?

    func select(card: Card) {
        selectedCard = card
    }
}

class User: Player {
    var isWinner: Bool?
    private(set) var isFinalWinner: Bool?
    var winCount: Int = 0 {
        didSet {
            if winCount >= 3 {
                isFinalWinner = true
            }
        }
    }
    var loseCount: Int = 0 {
        didSet {
            if loseCount >= 3 {
                isFinalWinner = false
            }
        }
    }
    var selectedCard: Card?

    func select(card: Card) {
        selectedCard = card
    }
    
    func win() {
        winCount += 1
    }
    
    func lose() {
        loseCount += 1
    }
}

enum Card: Int, CaseIterable {
    case rock = 0
    case paper = 1
    case scissors = 2
    
    var desc: String {
        switch self {
        case .rock: "✊"
        case .paper: "🖐️"
        case .scissors: "✌️"
        }
    }
}
