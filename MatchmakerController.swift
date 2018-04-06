//
//  MatchMakerController.swift
//  Concentration
//
//  Created by Yiwen Gao on 3/10/18.
//  Copyright © 2018 Yiwen Gao. All rights reserved.
//

//if internal class interface, go to top and switch to automatic
import UIKit

class MatchmakerController: UIViewController { //superclass is UIViewController
    
    /*lazy means doesn't have to be initialized till used
     game has to be lazy bc depends on other global var cardButtons*/
    private lazy var game = Matchmaker(numberOfButtons: cardButtons.count)
    @IBOutlet private var cardButtons: [UIButton]!
    private var cardValues = [Int: String]() //or Dictionary<Int, String>()
    private var emojis = ["💗", "💖", "💕", "💘", "💞", "💓", "💝", "❣️"]
    
    //    var theme = "" {
    //        didSet {
    //            emojis = [String]()
    //            for emoji in theme {
    //                emojis.append(String(emoji))
    //            }
    //        }
    //    }
    
    private(set) var score = 0 { didSet { scoreLabel.text = "SCORE \(score)" } }
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        let index = cardButtons.index(of: sender)!
        let card = game.cards[index]
        if card.isMatched == false {
            if cardValues[card.id] == nil {
                let randomIndex = Int(arc4random_uniform(UInt32(emojis.count)))
                cardValues[card.id] = emojis.remove(at: randomIndex)
            }
            
            updateView(at: index)
        }
    }
    
    private func updateView(at index: Int) {
        flipOneCard(at: index)
        
        if let faceUpCardIndex = game.faceUpCardIndex {
            let outcome = game.compareCards(at: index)
            if outcome {
                score += 1
            }
            else {
                score -= 1
            }
            
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (Timer) in
                self.flipTwoCards(at: index, andAt: faceUpCardIndex, because: outcome)
            })
        }
        game.determineFaceUpCardIndex(because: index)
    }
    
    private func flipOneCard(at index: Int) {
        let button = cardButtons[index]
        let card = game.cards[index]
        let emoji = cardValues[card.id]
        
        if card.isFaceUp {
            button.setTitle("M", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            game.cards[index].isFaceUp = false
        }
        else if !card.isFaceUp {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            game.cards[index].isFaceUp = true
        }
    }
    
    private func flipTwoCards(at index1: Int, andAt index2: Int, because match: Bool) {
        var buttonTitle = "M"
        var backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        if match {
            buttonTitle = ""
            backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        }
        
        cardButtons[index1].setTitle(buttonTitle, for: UIControlState.normal)
        cardButtons[index1].backgroundColor = backgroundColor
        game.cards[index1].isFaceUp = false
        cardButtons[index2].setTitle(buttonTitle, for: UIControlState.normal)
        cardButtons[index2].backgroundColor = backgroundColor
        game.cards[index2].isFaceUp = false
    }
}
