//
//  RockPaperScissors - GameView.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

protocol GameViewDelegate: AnyObject {
    func resetButton()
    func playButton()
    func selectRock()
    func selectPaper()
    func selectScissors()
}

class GameView: UIView {

    private let computerHandLabel: UILabel = UILabel()
    private let userHandLabel: UILabel = UILabel()
    private let resultLabel: UILabel = UILabel()
    private let currentWinLoseLabel: UILabel = UILabel()
    weak var delegate: GameViewDelegate?
    
    func setComputerHand(with card: Card?) {
        if let card = card {
            computerHandLabel.text = card.desc
        } else {
            computerHandLabel.text = ""
        }
    }
    
    func setUserHand(with card: Card?) {
        if let card = card {
            userHandLabel.text = card.desc
        } else {
            userHandLabel.text = ""
        }
    }
    
    func setCurrentWinLoseLabel(win: Int, lose: Int) {
        currentWinLoseLabel.text = "\(win)승 \(lose)패"
    }
    
    func setResultLabel(with text: String) {
        resultLabel.text = text
    }
    
    @objc private func touchUpResetButton() {
        delegate?.resetButton()
    }
    
    @objc private func touchUpPlayButton() {
        delegate?.playButton()
    }
    
    @objc private func touchUpPaperHand() {
        setUserHand(with: Card.paper)
        delegate?.selectPaper()
    }
    
    @objc private func touchUpRockHand() {
        setUserHand(with: Card.rock)
        delegate?.selectRock()
    }
    
    @objc private func touchUpScissorHand() {
        setUserHand(with: Card.scissors)
        delegate?.selectScissors()
    }
    
    private func initialSetup() {
        backgroundColor = .white
        
        resultLabel.text = ""
        currentWinLoseLabel.text = "0승 0패"
        
        computerHandLabel.font = .systemFont(ofSize: 40)
        userHandLabel.font = .systemFont(ofSize: 40)
        resultLabel.font = .preferredFont(forTextStyle: .headline)
        currentWinLoseLabel.font = .preferredFont(forTextStyle: .largeTitle)
        
        [computerHandLabel, userHandLabel, resultLabel, currentWinLoseLabel].forEach { label in
            label.textColor = .black
            label.textAlignment = .center
        }
    }
    
    private func layViews() {
        
        let topClearView: UIView = UIView()
        topClearView.backgroundColor = .clear
        
        let resetButton: UIButton = UIButton(type: .roundedRect)
        resetButton.setTitle("RESET", for: .normal)
        resetButton.addTarget(self, action: #selector(touchUpResetButton), for: .touchUpInside)
        
        let middleTopClearView: UIView = UIView()
        middleTopClearView.backgroundColor = .clear
        
        let computerLabel: UILabel = UILabel()
        computerLabel.text = "컴퓨터"
        computerLabel.textColor = .black
        computerLabel.textAlignment = .center
        computerLabel.font = .preferredFont(forTextStyle: .subheadline)
                
        let userLabel: UILabel = UILabel()
        userLabel.text = "나"
        userLabel.textColor = .black
        userLabel.textAlignment = .center
        userLabel.font = .preferredFont(forTextStyle: .subheadline)
        
        let computerHandStackView: UIStackView = .init(arrangedSubviews: [computerLabel, computerHandLabel])
        computerHandStackView.axis = .vertical
        
        let userHandStackView: UIStackView = .init(arrangedSubviews: [userLabel, userHandLabel])
        userHandStackView.axis = .vertical
        
        let handsStackView: UIStackView = .init(arrangedSubviews: [computerHandStackView, userHandStackView])
        handsStackView.axis = .horizontal
        handsStackView.distribution = .fillEqually
        
        let middleBottomClearView: UIView = UIView()
        middleBottomClearView.backgroundColor = .clear
        
        let buttonStackView: UIStackView = .init(arrangedSubviews: [resetButton])
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .center
        buttonStackView.distribution = .fillEqually
        
        let bottomClearView: UIView = UIView()
        bottomClearView.backgroundColor = .clear

        let rockButton: UIButton = UIButton(type: .roundedRect)
        rockButton.setTitle(Card.rock.desc, for: .normal)
        rockButton.addTarget(self, action: #selector(touchUpRockHand), for: .touchUpInside)
        
        let scissorButton: UIButton = UIButton(type: .roundedRect)
        scissorButton.setTitle(Card.scissors.desc, for: .normal)
        scissorButton.addTarget(self, action: #selector(touchUpScissorHand), for: .touchUpInside)
        
        let paperButton: UIButton = UIButton(type: .roundedRect)
        paperButton.setTitle(Card.paper.desc, for: .normal)
        paperButton.addTarget(self, action: #selector(touchUpPaperHand), for: .touchUpInside)
        
        let changeHandButtonStackView: UIStackView = .init(arrangedSubviews: [rockButton, scissorButton, paperButton])
        changeHandButtonStackView.axis = .horizontal
        changeHandButtonStackView.alignment = .center
        changeHandButtonStackView.distribution = .fillEqually
        
        let playButton: UIButton = UIButton(type: .roundedRect)
        playButton.setTitle("PLAY", for: .normal)
        playButton.addTarget(self, action: #selector(touchUpPlayButton), for: .touchUpInside)
        
        let playButtonStackView: UIStackView = .init(arrangedSubviews: [playButton, changeHandButtonStackView])
        playButtonStackView.axis = .horizontal
        playButtonStackView.alignment = .center
        playButtonStackView.distribution = .fillEqually
        
        let mainStackView: UIStackView = .init(arrangedSubviews: [topClearView, currentWinLoseLabel, middleTopClearView, handsStackView, resultLabel, middleBottomClearView, playButtonStackView, buttonStackView, bottomClearView])
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainStackView)
        
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            safeArea.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            safeArea.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            safeArea.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            safeArea.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            topClearView.heightAnchor.constraint(equalTo: bottomClearView.heightAnchor),
            topClearView.heightAnchor.constraint(equalTo: middleTopClearView.heightAnchor),
            topClearView.heightAnchor.constraint(equalTo: middleBottomClearView.heightAnchor)
        ])
    }
    
    init(delegate: GameViewDelegate) {
        super.init(frame: .zero)
        initialSetup()
        layViews()
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
