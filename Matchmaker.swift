//
//  Concentration.swift
//  Concentration
//
//  Created by Yiwen Gao on 3/13/18.
//  Copyright © 2018 Yiwen Gao. All rights reserved.
//

import Foundation

class Matchmaker {
    //classes get an init() for free
    
    var cards = [Card]() //or Array<Card>()
    var faceUpCardIndex: Int? //{
//        get {
//            if self.faceUpCardIndex == nil {
//                for index in cards.indices {
//                    if cards[index].isFaceUp == true {
//                        return index
//                    }
//                }
//            }
//            return nil
//        }
////        set {
////
////        }
//    }
    
    init(numberOfButtons: Int) {
        while cards.count < numberOfButtons {
            /*putting structs in arrays also copies them
             so actually three cards with same id*/
            let card = Card()
            var randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards.insert(card, at: randomIndex)
            randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards.insert(card, at: randomIndex) //can also append with cards += [card, card]
        }
    }
    
    func compareCards(at index: Int) -> Bool {
        if faceUpCardIndex! == index {
            return false
        }
        
        let faceUpCard = cards[faceUpCardIndex!]
        let card = cards[index]
        if faceUpCard.id == card.id {
            cards[faceUpCardIndex!].isMatched = true
            cards[index].isMatched = true
            return true
        }
        return false
    }

    func determineFaceUpCardIndex(because index: Int) {
        if faceUpCardIndex == nil {
            faceUpCardIndex = index
        }
        else {
            faceUpCardIndex = nil
        }
    }
}
