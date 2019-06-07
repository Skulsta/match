//
//  ViewController.swift
//  match
//
//  Created by Stian on 30/05/2019.
//  Copyright © 2019 Stian Skulstad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    var timer:Timer?
    
    var milliseconds:Float = 45 * 1000 // 30 seconds
    
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the cards
        cardArray = CardModel.getCards()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Instanciate the Timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    // MARK: Timer methods
    
    @objc func timerElapsed() {
        
        // Updating the label constantly
        milliseconds -= 1
        
        // Convert to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
    
        timerLabel.text = "Time remaining: \(seconds)"
        
        // When the timer has reached 0. Stop it. Also, the player has lost.
        if milliseconds <= 0 {
            timer?.invalidate() // Stop it from ever firing off again.
            timerLabel.textColor = UIColor.red
            
            // Check if there are any cards left
            checkWinCondition()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        cell.setCard(cardArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if !card.isFlipped && !card.isMatched {
            cell.flip()
            card.isFlipped = true
            
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            }
            else {
                // This is the second card being flipped
                
                // Look for similarity and flip them back or remove them.
                compareCards(indexPath)
                firstFlippedCardIndex = nil
            }
        }
    }
    
    func compareCards(_ secondFlippedCardIndex:IndexPath) {
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        if cardOne.imageName == cardTwo.imageName {
            
            // Found a matching pair. Set the statuses to true
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            // Remove the cells
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            // Check if those were the last two cards
            checkWinCondition()
            
        }
        else {
            
            // The cards didn't match. Flip them back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
            // Change their flip statuses back to false 
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
        }
        
        // Make sure the first card cell does not get reused when we scroll it out of view and there is a match
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
    }
    
    func checkWinCondition() {
        
        // Determine if there are any cards unmatched
        var isWon = true
        
        for card in cardArray {
            if card.isMatched == false {
                isWon = false
                break
            }
        }
        
        // Messaging variables
        var title = "Congratulations!"
        var message = "You've won"
        
        
        // The player has won. Stop the timer.
        if isWon == true {
            if milliseconds > 0 {
                timer?.invalidate()
            }
        }
        else {
            if milliseconds > 0 {
                return
            }
            
            // The player has lost
            title = "Game Over"
            message = "You've lost"
        }
        
        
        showAlert(title, message)

    }
    
    
    func showAlert (_ title: String, _ message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}


