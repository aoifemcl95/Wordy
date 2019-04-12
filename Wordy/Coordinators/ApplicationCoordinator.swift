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
    }
    
    func start() {
        window.rootViewController = rootViewController
        searchCoordinator.start()
        window.makeKeyAndVisible()
    }

    
}
