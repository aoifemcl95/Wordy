//
//  FavouriteService.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 19/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class FavouriteService: NSObject {

    var favouriteWords = UserDefaults.standard.object(forKey: "WordyFavouriteWordKey") as? [String] ?? [String]()
    
    func isFavourited(word:String) -> Bool {
        return favouriteWords.contains(word)
        
    }
    
    func setFavourite(word:String)
    {
        favouriteWords.append(word)
        UserDefaults.standard.set(favouriteWords, forKey: "WordyFavouriteWordKey")
    }
    
    func removeFavourite(word:String)
    {
        if let index = favouriteWords.index(of:word)  {
            favouriteWords.remove(at: index)
            UserDefaults.standard.set(favouriteWords, forKey: "WordyFavouriteWordKey")
        }
    }
    
}
