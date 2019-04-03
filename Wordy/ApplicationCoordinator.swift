//
//  MainCoordinator.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 02/04/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    var rootViewController: UINavigationController
    var window: UIWindow
    var searchCoordinator: SearchCoordinator
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        
        searchCoordinator = SearchCoordinator(presenter: rootViewController)
//        let emptyViewController = UIViewController()
//        emptyViewController.view.backgroundColor = .cyan
//        rootViewController.pushViewController(emptyViewController, animated: false)
    }
    
    func start() {
        window.rootViewController = rootViewController
        searchCoordinator.start()
        window.makeKeyAndVisible()
    }
    
//    func showCard(word: String, exampleArray: [[Example]]?, definitionArray: [[String]]) {
//        let vc = DetailViewController(exampleArray: exampleArray, definitionArray: definitionArray)
//        vc.coordinator = self
//        vc.word = word
//        navigationController.pushViewController(vc, animated: true)
//    }
    
}
