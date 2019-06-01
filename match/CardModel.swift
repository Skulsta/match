//
//  CardModel.swift
//  match
//
//  Created by Stian on 30/05/2019.
//  Copyright © 2019 Stian Skulstad. All rights reserved.
//

import Foundation

class CardModel {
    
    static func getCards() -> [Card] {
        
        // Instanciate an array to store the cards
        var cardArray = [Card]()
        
        // Loop eight times to create 8 pairs of cards and add them to the array
        while cardArray.count < 16 {
            
            // Generate random numbers from 1 to 13
            let randomNumber = arc4random_uniform(12) + 1
            
            // Does this number already exist?
            var existingCard = false
            
            // Create two cards with the same value and add them to the array
            for card in cardArray {
                
                if card.imageName == "card\(randomNumber)" {
                    
                    existingCard = true
                }
            }
                    
            if existingCard == false {
            
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                cardArray.append(cardOne)
                
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                cardArray.append(cardTwo)
            }
            
        }
        
        // Shuffle the cards
        cardArray.shuffle()
        
        return cardArray
        
    }
    
}
