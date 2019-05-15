//
//  ServiceFactory.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 15/05/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class ServiceFactory: NSObject {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    let favouriteService: FavouriteService!
    
    override init() {
        self.favouriteService = delegate.favouriteService
    }

}
