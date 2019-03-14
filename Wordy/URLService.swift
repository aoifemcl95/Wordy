//
//  URLService.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 08/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit
import Alamofire

class URLService: NSObject {

    func fetchWords(word: String, completion: @escaping([Result]?) -> Void) {
        if let urlString = "https://od-api.oxforddictionaries.com/api/v1/entries/en/\(word)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            Alamofire.request(url, headers: ["app_id":"7b9482bd", "app_key" : "dff87c78a175a256a58265b7aba724f0"])
                .validate()
                .responseJSON { (response) in
                    guard response.result.isSuccess else {
                        completion(nil)
                        return
                    }
                    
                    if let responseData = response.data {
                        if let result = try? JSONDecoder().decode(EntriesResult.self, from: responseData) {
                            let results = result.results
                            completion(results)
                        }
                        
                    }
            } 
        }
        
    }
    
    
    func makeSearch(query: String, completion: @escaping([SearchResult]?) -> Void) {
        guard let url = URL(string: "https://od-api.oxforddictionaries.com/api/v1/search/en?q=\(query)") else {
            completion(nil)
            return
        }
        Alamofire.request(url, headers: ["app_id":"7b9482bd", "app_key" : "dff87c78a175a256a58265b7aba724f0"])
            .validate()
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    completion(nil)
                    return
                }
                
                if let responseData = response.data {
                    if let searchResults = try? JSONDecoder().decode(SearchResults.self, from: responseData) {
                        completion(searchResults.results)
                    }
                    
                }
        }
    }
    
    
    
}
