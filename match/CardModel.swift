//
//  CardModel.swift
//  match
//
//  Created by Stian on 30/05/2019.
//  Copyright © 2019 Stian Skulstad. All rights reserved.
//

import Foundation

class CardModel {
    
    // Instanciate an array to store the cards
    var cardArray = [Card]()
    
    func getCards() -> [Card] {
        
        // Loop eight times to create 8 pairs of cards and add them to the array
        for _ in 1...8 {
            
            // Generate random numbers from 1 to 13
            let randomNumber = arc4random_uniform(12) + 1
            
            // Create two cards with the same value and add them to the array
            let cardOne = Card()
            cardOne.imageName = "card\(randomNumber)"
            cardArray.append(cardOne)
            
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomNumber)"
            cardArray.append(cardTwo)
            
        }
        
        return cardArray
        
    }
    
}
