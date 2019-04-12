//
//  MainTabBarController.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 12/04/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let searchCoordinator = SearchCoordinator(presenter: UINavigationController())
    let recentCoordinator = RecentsCoordinator(presenter: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recentCoordinator.start()
        searchCoordinator.start()
        viewControllers = [recentCoordinator.presenter, searchCoordinator.presenter]

        // Do any additional setup after loading the view.
    }


}
