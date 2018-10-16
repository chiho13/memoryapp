//
//  Concentration.swift
//  Concentration
//
//  Created by Anthony Ho on 06/10/2018.
//  Copyright © 2018 Anthony Ho. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexofOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexofOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                
                cards[index].isFaceUp = true
                indexofOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards   or 2 cards or faced up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                
                cards[index].isFaceUp = true
                indexofOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //TODO: shuffle the cards
    }
}
