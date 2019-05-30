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
        
        frontCardImageView.image = UIImage(named: card.imageName)
    }
    
    func flip() {
        UIView.transition(from: backCardImageView, to: frontCardImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    
    func flipBack() {
        
    }
    
}
