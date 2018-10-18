//
//  Concentration.swift
//  Concentration
//
//  Created by Anthony Ho on 06/10/2018.
//  Copyright © 2018 Anthony Ho. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    
    private(set) var flipCount = 0
    private(set) var score = 0
    private var seenCards: Set<Int> = []
    
    private struct Points {
        static let matchBonus = 2
        static let missMatchPenalty = 1
    }
    
    private var indexofOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexofOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += Points.matchBonus
                } else {
                    if seenCards.contains(index), seenCards.contains(matchIndex)  {
                        score -= Points.missMatchPenalty
                    }
                    
                    seenCards.insert(index)
                    seenCards.insert(matchIndex)
                }
                
                cards[index].isFaceUp = true
            } else {
                indexofOneAndOnlyFaceUpCard = index
            }
             flipCount += 1
        }
    }
    
    mutating func resetGame() {
        flipCount = 0
        score = 0
        seenCards = []
        for index in cards.indices  {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        shuffleCards()
    }
    
    mutating func shuffleCards() {
        for _ in 1...cards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards.swapAt(0, randomIndex)
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
        //TODO: shuffle the cards
    }
}
