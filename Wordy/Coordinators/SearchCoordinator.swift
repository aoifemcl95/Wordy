//
//  SwiftCoordinator.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 03/04/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class SearchCoordinator: Coordinator {
    public let presenter: UINavigationController
    private var searchTableViewController: SearchTableViewController?
    private var cardCoordinator: CardCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let searchTableViewController = SearchTableViewController(nibName:nil, bundle: nil)
        searchTableViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        searchTableViewController.delegate = self
        presenter.pushViewController(searchTableViewController, animated: true)
        self.searchTableViewController = searchTableViewController
    }
}

extension SearchCoordinator: SearchTableViewControllerDelegate {
    func searchTableViewControllerDidSelectResult(word: String) {
        let cardCoordinator = CardCoordinator(presenter: presenter, word: word)
        cardCoordinator.start()
        self.cardCoordinator = cardCoordinator
    }
}
