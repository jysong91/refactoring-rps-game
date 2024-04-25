//
//  RockPaperScissors - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class GameViewController: UIViewController {

    private var user: User = User()
    private var computer: Computer = Computer()
    
    override func loadView() {
        view = GameView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        play()
    }
    
    private func play() {
        guard let userCard = Card.allCases.randomElement(),
            let computerCard = Card.allCases.randomElement() else { return }
        user.select(card: userCard)
        computer.select(card: computerCard)
    }
    
    private func showResult() {
        guard let userCard = user.selectedCard, let computerCard = computer.selectedCard else { return }
        let cal = userCard.rawValue - computerCard.rawValue

        if cal == 0 {
            user.draw()
        }
        if cal < 0 {
            user.lose()
        }
        if cal > 0 {
            user.win()
        }
        if cal == -2 {
            user.win()
        }
        if cal == 2 {
            user.lose()
        }
        
        if let isWinner = user.isWinner {
            user = User()
            computer = Computer()
            play()
            return
        }
        
        play()
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
    var winCount: Int = 0 {
        didSet {
            if winCount >= 3 {
                isWinner = true
            }
        }
    }
    var drawCount: Int = 0
    var loseCount: Int = 0 {
        didSet {
            if loseCount >= 3 {
                isWinner = false
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
    
    func draw() {
        drawCount += 1
    }

    func lose() {
        loseCount += 1
    }
}

enum Card: Int, CaseIterable {
    case rock = 0
    case paper = 1
    case scissors = 2
}
