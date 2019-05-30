//
//  ViewController.swift
//  match
//
//  Created by Stian on 30/05/2019.
//  Copyright © 2019 Stian Skulstad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cardModel = CardModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardModel.getCards()
    }


}

