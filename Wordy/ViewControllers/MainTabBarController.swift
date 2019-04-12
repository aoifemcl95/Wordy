//
//  MainTabBarController.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 12/04/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let cardCoordinator = CardCoordinator(presenter: UINavigationController(), word: nil)
    let searchCoordinator = SearchCoordinator(presenter: UINavigationController())
    let recentCoordinator = RecentsCoordinator(presenter: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCoordinator.start()
        recentCoordinator.start()
        viewControllers = [searchCoordinator.presenter, recentCoordinator.presenter]

        // Do any additional setup after loading the view.
    }


}
