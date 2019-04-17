//
//  FavouriteService.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 19/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit
import CoreData


class FavouriteService: NSObject {

    let nc = NotificationCenter.default
    let wordLimit = 3
    
    
    static var words: [NSManagedObject] {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
             let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Word")
            do {
                return try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
                return []
                print("\(error)")
            }
        }
        return []
    }

    static func isFavourited(word:String) -> Bool {
            for wordObject in words {
                if wordObject.value(forKeyPath: "name") as? String == word {
                     return true
                }
            }
        return false
        }
    

    
    static func saveFavourite(name: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Word", in: managedContext)!
        
        let word = NSManagedObject(entity: entity, insertInto: managedContext)
        
        word.setValue(name, forKeyPath: "name")
        
        do {
            try managedContext.save()
//            words.append(word)
        } catch let error as NSError {
            print("\(error)")
        }
    }

//    func removeFavourite(word:String)
//    {
//        var favouriteWords = words
//        if let index = favouriteWords.index(of:word)  {
//            favouriteWords.remove(at: index)
//        }
//        UserDefaults.standard.set(favouriteWords, forKey: "WordyFavouriteWordKey")
//    }

    
}
