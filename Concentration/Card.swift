//
//  Card.swift
//  Concentration
//
//  Created by Valery Nevzorov on 15.12.2021.
//

import Foundation

struct Card {
    
    // card is facing down and is not mathched by default
    var isFaceUp = false
    var isMatched = false
    var id: Int
    
    private static var idFactory = 0
    
    private static func getUniqueId() -> Int {
        idFactory += 1
        return idFactory
    }
    
    init() {
        self.id = Card.getUniqueId()
    }
    
}
