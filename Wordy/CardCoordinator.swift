//
//  CardCoordinator.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 03/04/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class CardCoordinator: Coordinator {
    private var presenter: UINavigationController
    private var cardController: DetailViewController?
//    private var exampleArray: [[Example]]?
//    private var definitionArray: [[String]]
    private var word: String
    
//    init(presenter: UINavigationController,exampleArray: [[Example]]?, definitionArray: [[String]]) {
    init(presenter: UINavigationController, word: String) {
        self.presenter = presenter
        self.word = word
//        self.exampleArray = exampleArray
//        self.definitionArray = definitionArray
    }
    
    func start() {
//        let cardController = DetailViewController(exampleArray: exampleArray, definitionArray: definitionArray)
        let cardController = DetailViewController(word: word)
        presenter.pushViewController(cardController, animated: true)
        self.cardController = cardController
    }
}


