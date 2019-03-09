//
//  ViewController.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 07/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit
import SwiftOxfordAPI
import Fuse

struct Item {
    let name: String
}

class ViewController: UITableViewController {
    
    var allWords = [String]()
//    var testWords = ["hello", "hi", "hands", "heeeelllo", "byeeee", "happy", "happppppy"]
    let fuse = Fuse()
    var filteredWords = [NSAttributedString]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWords()
        //setup search controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        tableView.tableHeaderView = searchController.searchBar
        //makeRequest()
        
        
        
    }
    
    func getWords() {
        if let wordsURL = Bundle.main.url(forResource: "test_words", withExtension: "txt") {
            if let words = try? String(contentsOf: wordsURL) {
                allWords = words.components(separatedBy: "\n")
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredWords.count
        }
        return allWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item: NSAttributedString
        
        if searchController.isActive && searchController.searchBar.text != "" && filteredWords.count > indexPath.row {
                item = filteredWords[indexPath.row]
            
            
        } else {
            item = NSAttributedString(string: allWords[indexPath.row])
        }
        
        cell.textLabel!.attributedText = item
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var chosenString: String
        if filteredWords.count > indexPath.row {
            chosenString = filteredWords[indexPath.row].string
        }
        else {
            chosenString = allWords[indexPath.row]
        }
        
        makeRequest(word: chosenString)
    }
    
    func filterContentForSearchText(_ searchText: String) {
            let boldAttrs = [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17),
                NSAttributedString.Key.foregroundColor: UIColor.blue
            ]
            fuse.search(searchText, in: allWords, completion: { results in
                self.filteredWords = results.map { (index, _, matchedRanges) in
                    let word = self.allWords[index]
                    
                    let attributedString = NSMutableAttributedString(string: word)
                    matchedRanges
                        .map(Range.init)
                        .map(NSRange.init)
                        .forEach {
                            attributedString.addAttributes(boldAttrs, range: $0)
                    }
                    
                    return attributedString
                }
            })
        
   
        
        tableView.reloadData()
    }
    

    
    func makeRequest(word: String) {
        var derivativeArray = [String]()
        var definitionsArray = [String]()
        var examplesArray = [Example]()
        var shortDefs = [String]()
        let language = "en"
//        let word = "Ace"
        let word_id = word.lowercased() //word id is case sensitive and lowercase is required
        let urlService = URLService()
        urlService.fetchWords(word: word) { (results) in
            let id = results?.first?.id
            if let lexicalEntries = results?.first?.lexicalEntries {
                for lexicalEntry in lexicalEntries {
                    if let derivatives = lexicalEntry.derivatives {
                        for derivative in derivatives {
                            derivativeArray.append(derivative.text)
                        }
                    }
                    let entries = lexicalEntry.entries
                    for entry in entries {
                        let etymologies = entry.etymologies
                        let senses = entry.senses
                        for sense in senses {
                            if let definitions = sense.definitions
                            {
                                for definition in definitions {
                                    definitionsArray.append(definition)
                                }
                                if let examples = sense.examples {
                                    for example in examples {
                                        examplesArray.append(example)
                                    }
                                    let shortDefinitions = sense.shortDefinitions
                                    for shortDef in shortDefinitions {
                                        shortDefs.append(shortDef)
                                    }
                                }
                            }
                        }
                    }
                }
            }
//            let vc = DetailViewController(nibName:"DetailViewController", bundle:nil)
            
            let vc = DetailViewController(example: examplesArray.first)
            vc.word = word
            vc.shortDefinition = definitionsArray.first
            vc.example = examplesArray.first
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }

}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

