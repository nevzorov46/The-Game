//
//  Card.swift
//  Concentration
//
//  Created by Valery Nevzorov on 15.12.2021.
//

import Foundation

struct Card: Hashable {
    
    var hashValue: Int {
        return id
    }

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    // card is facing down and is not mathched by default
    var isFaceUp = false
    var isMatched = false
    private var id: Int
    
    private static var idFactory = 0
    
    private static func getUniqueId() -> Int {
        idFactory += 1
        return idFactory
    }
    
    init() {
        self.id = Card.getUniqueId()
    }
    
}
