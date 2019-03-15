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
    
    var searchResults = [SearchResult]()
    let fuse = Fuse()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup search controller
        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        tableView.tableHeaderView = searchController.searchBar
        //makeRequest()
        
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return self.searchResults.count
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item: String
        
        if searchController.isActive && searchController.searchBar.text != "" && self.searchResults.count > indexPath.row {
                item = self.searchResults[indexPath.row].word
            
            
       }
        else {
            item = ""
        }
        
        cell.textLabel!.text = item
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var chosenString: String
        if self.searchResults.count > indexPath.row {
            chosenString = self.searchResults[indexPath.row].word
        }
        else {
            chosenString = ""
        }
        
        makeRequest(word: chosenString)
    }

    func makeRequest(word: String) {
        var derivativeArray = [String]()
        var definitionsArray = [[String]]()
        var examplesArray = [[Example]]()
        var shortDefs = [String]()
        let urlService = URLService()
        urlService.fetchWords(word: word) { (results) in
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
                        guard let senses = entry.senses else { return }
                        for sense in senses {
                            if let definitions = sense.definitions
                            {
                                definitionsArray.append(definitions)
                                if let examples = sense.examples {
                                    examplesArray.append(examples)
                                    guard let shortDefinitions = sense.shortDefinitions else { return }
                                    for shortDef in shortDefinitions {
                                        shortDefs.append(shortDef)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            let vc = DetailViewController(exampleArray: examplesArray, definitionArray: definitionsArray)
            vc.word = word
//            vc.shortDefinition = definitionsArray.first
//            vc.definitionArray = definitionsArray
//            vc.exampleArray = examplesArray
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}



extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.tableView.reloadData()
        let urlService = URLService()
        guard let searchBarText = searchController.searchBar.text else { return }
        if (searchBarText.count > 3 && searchController.isActive) {
            guard let query = searchController.searchBar.text else { return }
            urlService.makeSearch(query: query) { (searchResults) in
                self.searchResults.removeAll()
                guard let searchResults = searchResults else  {return }
                let orderedSearchResults = searchResults.sorted(by: { $0.score > $1.score })
                for searchResult in orderedSearchResults {
                    self.searchResults.append(searchResult)
                    
                }
                self.tableView.reloadData()
            }
            
        }
        self.tableView.reloadData()
    }
}

