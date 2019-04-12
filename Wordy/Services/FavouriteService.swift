//
//  FavouriteService.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 19/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

public protocol FavouriteServiceProtocol: Any {
    var words: [String] { get }
    var hasFavourites: Bool { get }
    func addFavourite(word:String)
    func removeFavourite(word:String)
    func clearFavourites()
}

class FavouriteService: NSObject {

    let nc = NotificationCenter.default
    
    var words: [String] {
        if let favouriteWords = UserDefaults.standard.array(forKey: "WordyFavouriteWordKey") as? [String] {
             return favouriteWords
        }
        return [String]()
    }
    
    func isFavourited(word:String) -> Bool {
        return words.contains(word)
        
    }
    
    var hasFavourites: Bool {
        return words.count > 0
    }
    
    func addFavourite(word:String)
    {
        var favouriteWords = words
        if let index = favouriteWords.index(of: word) {
            favouriteWords.remove(at: index)
        }
        favouriteWords.insert(word, at: 0)
        
        UserDefaults.standard.set(favouriteWords, forKey: "WordyFavouriteWordKey")
        nc.post(name: Notification.Name("FavouriteAdded"), object: nil)
    }
    
    func removeFavourite(word:String)
    {
        var favouriteWords = words
        if let index = favouriteWords.index(of:word)  {
            favouriteWords.remove(at: index)
        }
        UserDefaults.standard.set(favouriteWords, forKey: "WordyFavouriteWordKey")
    }
    
    func clearFavourites() {
        UserDefaults.standard.set(nil, forKey: "WordyFavouriteWordKey")
    }
    
}
