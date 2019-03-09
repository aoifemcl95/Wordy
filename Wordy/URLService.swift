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
        guard let url = URL(string: "https://od-api.oxforddictionaries.com/api/v1/entries/en/\(word)") else {
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
                    let decoder = JSONDecoder()
                    if let result = try? JSONDecoder().decode(EntriesResult.self, from: responseData) {
                        let results = result.results
                        completion(results)
                    }
                    
                }
                
                if let result = response.result.value {
                    
                }
                
//                if let responseData = response.data {
//
//                    if let entriesResult = try? decoder.decode(EntriesResult.self, from: responseData) {
//                        let results = entriesResult.results
//                        completion(results)
//                    }
//                }
        }
        
        
    }
    
}
