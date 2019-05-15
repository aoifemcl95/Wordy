//
//  FavouriteService.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 19/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit
import CoreData
import FirebaseDatabase

protocol FavouriteServiceProtocol  {
    var words: [String] {get}
    func isFavourited(word:String) -> Bool
    func saveFavourite(name: String)
}


class FavouriteService: FavouriteServiceProtocol {
    

    var words: [String]  {
        var favWords: [String] = []
        getWords { (wordArray) in
            favWords = wordArray
            }
        return favWords
    }
    
    func isFavourited(word:String) -> Bool {
        return words.contains(word)
    }
    
    func getWords(completion: @escaping([String]) -> Void) {
        var favouriteWords: [String] = []
        let ref = Database.database().reference(withPath: "favourites")
        ref.observe(.value) { (snapshot) in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    if let value = snapshot.value as? [String: String] {
                        let name = value["word"] ?? ""
                        favouriteWords.append(name)
                    }
                    
                }
            }
           completion(favouriteWords)
        }
    }
    

    
    func saveFavourite(name: String) {
        let ref = Database.database().reference(withPath: "favourites")
        let favouriteWordRef = ref.child(name.lowercased())
        favouriteWordRef.setValue(["word": name])
        NotificationCenter.default.post(name: .favouritesChanged, object: nil)
    }


    
}
