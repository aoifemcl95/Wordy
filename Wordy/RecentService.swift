//
//  RecentService.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 20/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

public protocol RecentServiceProtocol: Any {
    var words: [String] { get }
    func add(word:String)
    func remove(word:String)
    func clearWords()
}

class RecentService: RecentServiceProtocol {
    
    let wordLimit = 5
    var words: [String] {
        if let recentWords = UserDefaults.standard.array(forKey:"RecentWordsKey") as? [String] {
            return recentWords
        }
        return [String]()
    }
    
    func add(word: String) {
        var currentWords = words
        if let index = currentWords.index(of: word) {
            currentWords.remove(at: index)
        }
        currentWords.insert(word, at: 0)
        
        if currentWords.count > wordLimit {
            currentWords.removeSubrange(wordLimit..<currentWords.count)
        }
        UserDefaults.standard.set(currentWords, forKey: "RecentWordsKey")
        
    }
    
    func remove(word: String) {
        var currentWords = words
        if let index = currentWords.index(of: word) {
            currentWords.remove(at: index)
        }
        UserDefaults.standard.set(currentWords, forKey: "RecentWordsKey")
    }
    
    func clearWords() {
        UserDefaults.standard.set(nil, forKey: "RecentWordsKey")
    }
    
    
    

    
}
