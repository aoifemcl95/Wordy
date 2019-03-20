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
    let favouriteService = FavouriteService()
    let recentService = RecentService()
    
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
        if favouriteService.favouriteWords.count > 0 && recentService.words.count > 0 {
             return 3
        }
        else if favouriteService.favouriteWords.count <= 0 && recentService.words.count > 0 {
            return 2
        }
        else if favouriteService.favouriteWords.count > 0 && recentService.words.count <= 0 {
             return 2
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            if (favouriteService.favouriteWords.count > 0 && section == 0)
            {
                return favouriteService.favouriteWords.count
            }
            else {
                return self.searchResults.count
            }
            
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item: String
        
        if searchController.isActive && searchController.searchBar.text != "" && self.searchResults.count > indexPath.row {
            if (favouriteService.favouriteWords.count > 0 && indexPath.section == 0) {
                item = self.favouriteService.favouriteWords[indexPath.row]
            }
            else {
                 item = self.searchResults[indexPath.row].word
            }
              
            
       }
        else {
            item = ""
        }
        
        cell.textLabel!.text = item
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.favouriteService.favouriteWords.count > 0 && recentService.words.count > 0 {
            if section == 0 {
                return "Favourites"
            } else if section == 1 {
                return "Recents"
            } else {
                return "Words"
            }
        } else if self.favouriteService.favouriteWords.count > 0 && recentService.words.count <= 0 {
            return "Favourites"
        } else if favouriteService.favouriteWords.count <= 0 && recentService.words.count > 0 {
            return "Recents"
        }
        else {
            return "Words"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var chosenString: String
        
        if self.favouriteService.favouriteWords.count > 0 && indexPath.section == 0 {
            chosenString = self.favouriteService.favouriteWords[indexPath.row]
            chosenString = makeInflectionRequest(word: chosenString) ?? chosenString
        }
        else if self.searchResults.count > indexPath.row {
            chosenString = self.searchResults[indexPath.row].word
            chosenString = makeInflectionRequest(word: chosenString) ?? chosenString
        }
        else
        {
            chosenString = ""
        }
        recentService.add(word: chosenString)
        
        makeRequest(word: chosenString)
    }

    func makeRequest(word: String) {
        var derivativeArray = [String]()
        var definitionsArray = [[String]]()
        var examplesArray = [[Example]]()
        var etymologiesArray = [[String]]()
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
            vc.etymologies = etymologiesArray.first
//            vc.shortDefinition = definitionsArray.first
//            vc.definitionArray = definitionsArray
//            vc.exampleArray = examplesArray
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func makeInflectionRequest(word:String) -> String? {
        var inflectionWords = [String]()
        let urlService = URLService()
        urlService.lemmaSearch(query: word) { (results) in
            if let lexicalEntries = results?.first?.lexicalEntries {
                for lexicalEntry in lexicalEntries {
                    if let inflectionOfArray = lexicalEntry.inflectionOf {
                        for inflection in inflectionOfArray {
                            inflectionWords.append(inflection.text)
                        }
                    }
                }
            }
        }
        return inflectionWords.first
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

