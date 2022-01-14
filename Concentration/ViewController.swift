//
//  ViewController.swift
//  Concentration
//
//  Created by Valery Nevzorov on 14.12.2021.
//

import UIKit

class ViewController: UIViewController {

    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var emoji = [Int: String]()
    
    var indexTheme = 0 {
        didSet {
            emojiChoices = emojiThemes[keys [indexTheme]] ?? []
            emoji = [Int: String]()
        }
    }
    
    var keys: [String] {
        return Array(emojiThemes.keys)
    }
    
    private var emojiThemes: [String: [String]] = [
        "plants" : ["🌳", "🎄", "🦚", "🌵", "☘️", "🍁", "🌷", "🌾", "🌻"],
        "fruits" : ["🍏", "🍎", "🍐", "🍋", "🍊", "🍌", "🍑", "🥭", "🍓"],
        "sport" : ["🏀", "⚽️", "🏈", "⚾️", "🥎", "🏐", "🏒", "🎱", "⛸"],
        "haloween" : ["😈", "👻", "😱", "🎃", "💀", "🕸", "🕷", "🐲", "🎭"]
    ]
    
    lazy var game =  Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    
    var emojiChoices: [String] = []
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    
    @IBAction func newGameEvent(_ sender: Any) {
        game.resetGame()
        indexTheme = keys.count.arc4random
        updateViewFromModel()
        flipCount = 0
        
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : .systemPurple
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.id] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.id] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.id] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexTheme = keys.count.arc4random
        updateViewFromModel()
        
    }
}




