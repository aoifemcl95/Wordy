//
//  RecentsCoordinator.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 12/04/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class RecentsCoordinator: Coordinator {
    public var presenter: UINavigationController!
    private var recentViewController: RecentsTableViewController?
    private var cardCoordinator: CardCoordinator?
    
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let recentViewController = RecentsTableViewController()
        recentViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)
        recentViewController.delegate = self
        presenter.pushViewController(recentViewController, animated: true)
        self.recentViewController = recentViewController
    }
}

extension RecentsCoordinator: RecentsTableViewControllerDelegate {
    func didReceiveDelegateMethod(word: String) {
        let cardCoordinator = CardCoordinator(presenter: presenter, word: word)
        cardCoordinator.start()
        self.cardCoordinator = cardCoordinator
    }
}
