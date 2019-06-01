//
//  CardCollectionViewCell.swift
//  match
//
//  Created by Stian on 30/05/2019.
//  Copyright © 2019 Stian Skulstad. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var frontCardImageView: UIImageView!
    
    @IBOutlet weak var backCardImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card: Card) {
        
        self.card = card
        
        if card.isMatched {
            self.frontCardImageView.alpha = 0
            self.backCardImageView.alpha = 0
            
            return
        }
        else {
            self.frontCardImageView.alpha = 1
            self.backCardImageView.alpha = 1
        }
        
        
        frontCardImageView.image = UIImage(named: card.imageName)
        
        if card.isFlipped {
            UIView.transition(from: backCardImageView, to: frontCardImageView, duration: 0, options: .showHideTransitionViews, completion: nil)
        } else {
            UIView.transition(from: frontCardImageView, to: backCardImageView, duration: 0, options: .showHideTransitionViews, completion: nil)
        }
    }
    
    func flip() {
        
        // The actual flipping
        UIView.transition(from: backCardImageView, to: frontCardImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    func flipBack() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            UIView.transition(from: self.frontCardImageView, to: self.backCardImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        
    }
    
    func remove() {
        
        // Remove two cells from the view when a match has been found
        backCardImageView.alpha = 0
        
        // Animate the removal
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontCardImageView.alpha = 0
        }, completion: nil)
        
    }
    
}
