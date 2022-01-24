//
//  ViewController.swift
//  Concentration
//
//  Created by Valery Nevzorov on 14.12.2021.
//

import UIKit

class ViewController: UIViewController {

    private var emoji = [Card: String]()
    
    var indexTheme = 0 {
        didSet {
            emojiChoices = emojiThemes[indexTheme].emoji
            backgroundColor = emojiThemes[indexTheme].viewColor
            cardColor = emojiThemes[indexTheme].cardColor
            emoji = [Card: String]()
        }
    }
    
    
    var backgroundColor = UIColor.gray
    var cardColor = UIColor.systemPurple
    
    
    private var emojiThemes = [
    Theme(name: "plants", emoji: ["🌳", "🎄", "🦚", "🌵", "☘️", "🍁", "🌷", "🌾", "🌻"], viewColor: UIColor(red: 117/255, green: 249/255, blue: 150/255, alpha: 0.98), cardColor: UIColor(red: 250/255, green: 179/255, blue: 99/255, alpha: 0.98)),
    Theme(name: "fruits", emoji: ["🍏", "🍎", "🍐", "🍋", "🍊", "🍌", "🍑", "🥭", "🍓"], viewColor: .cyan, cardColor: .purple),
        Theme(name: "sport", emoji: ["🏀", "⚽️", "🏈", "⚾️", "🥎", "🏐", "🏒", "🎱", "⛸"], viewColor: .blue, cardColor: .gray),
        Theme(name: "haloween", emoji: ["😈", "👻", "😱", "🎃", "💀", "🕸", "🕷", "🐲", "🎭"], viewColor: .orange, cardColor: .black)
    ]

    
    private lazy var game =  Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    
    private var emojiChoices: [String] = []
    
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    
    @IBAction private func newGameEvent(_ sender: Any) {
        game.resetGame()
        indexTheme = emojiThemes.count.arc4random
        game.score = 0
        game.flipCount = 0
        view.backgroundColor = backgroundColor
        updateViewFromModel()
    }
    
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : cardColor
            }
            
            scoreLabel.text = "Score: \(game.score)"
            flipCountLabel.text = "Flips: \(game.flipCount)"
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.count.arc4random
            emoji[card] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexTheme = emojiThemes.count.arc4random
        view.backgroundColor = backgroundColor
        updateViewFromModel()
        
    }
}



