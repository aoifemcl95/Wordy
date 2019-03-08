//
//  ViewController.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 07/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit
import SwiftOxfordAPI

class ViewController: UIViewController {

    var derivativeArray = [String]()
    var definitionsArray = [String]()
    var examplesArray = [Example]()
    var shortDefs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest()
        
        
    }

    
    func makeRequest() {
        let language = "en"
        let word = "Ace"
        let word_id = word.lowercased() //word id is case sensitive and lowercase is required
        let urlService = URLService()
        urlService.fetchWords { (results) in
            let id = results?.first?.id
            if let lexicalEntries = results?.first?.lexicalEntries {
                for lexicalEntry in lexicalEntries {
                    guard let derivatives = lexicalEntry.derivatives else { return }
                    for derivative in derivatives {
                        self.derivativeArray.append(derivative.text)
                    }
                    let entries = lexicalEntry.entries
                    for entry in entries {
                        guard let etymologies = entry.etymologies else { return }
                        
                        let senses = entry.senses
                        for sense in senses {
                            let definitions = sense.definitions
                            for definition in definitions {
                                self.definitionsArray.append(definition)
                            }
                            guard let examples = sense.examples else { return }
                            for example in examples {
                                self.examplesArray.append(example)
                            }
                            let shortDefinitions = sense.shortDefinitions
                            for shortDef in shortDefinitions {
                                self.shortDefs.append(shortDef)
                            }
                            let vc = DetailViewController(nibName:"DetailViewController", bundle:nil)
                            vc.word = lexicalEntry.text
                            vc.shortDefinition = self.shortDefs.first
                            self.present(vc, animated: true, completion: nil)
                            
                        }
                    }
                    
                }
                
            }
            
        }
    }

}

