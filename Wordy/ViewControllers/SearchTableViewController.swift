//
//  SearchTableViewController.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 03/04/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit
import SwiftOxfordAPI
import Fuse

struct Item {
    let name: String
}
protocol SearchTableViewControllerDelegate: class {
    func searchTableViewControllerDidSelectResult(word: String)
}
class SearchTableViewController: UITableViewController {
    
    weak var delegate: SearchTableViewControllerDelegate?
    var searchResults = [SearchResult]()
    let fuse = Fuse()
    let favouriteService = FavouriteService()
    let recentService = RecentService()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchNib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.register(searchNib, forCellReuseIdentifier: "SearchTableViewCell")
        //setup search controller
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        tableView.tableHeaderView = searchController.searchBar
        
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if favouriteService.hasFavourites && recentService.hasWords {
            return 3
        }
        else if favouriteService.hasFavourites || recentService.hasWords {
            return 2
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            if (favouriteService.hasFavourites && recentService.hasWords)
            {
                switch (section) {
                case 0:
                    return favouriteService.words.count
                case 1:
                    return recentService.words.count
                default:
                    return self.searchResults.count
                    
                }
            }
            else if (favouriteService.hasFavourites && !recentService.hasWords) {
                switch (section) {
                case 0:
                    return favouriteService.words.count
                default:
                    return self.searchResults.count
                }
            }
            else if (!favouriteService.hasFavourites && recentService.hasWords) {
                switch (section) {
                case 0:
                    return recentService.words.count
                default:
                    return searchResults.count
                }
            }
            else {
                return searchResults.count
            }
            
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        let item: String
        
        if searchController.isActive && searchController.searchBar.text != "" && self.searchResults.count > indexPath.row {
            if (favouriteService.hasFavourites && recentService.hasWords) {
                switch (indexPath.section) {
                case 0:
                    item = favouriteService.words[indexPath.row]
                case 1:
                    item = recentService.words[indexPath.row]
                default:
                    item = searchResults[indexPath.row].word
                }
            } else if (favouriteService.hasFavourites && !recentService.hasWords) {
                switch (indexPath.section) {
                case 0:
                    item = favouriteService.words[indexPath.row]
                default:
                    item = searchResults[indexPath.row].word
                }
            } else if (!favouriteService.hasFavourites && recentService.hasWords) {
                switch (indexPath.section) {
                case 0:
                    item = recentService.words[indexPath.row]
                default:
                    item = searchResults[indexPath.row].word
                }
            } else {
                item = searchResults[indexPath.row].word
            }
        }
        else {
            item = ""
        }
        
        cell.textLabel!.text = item
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (favouriteService.hasFavourites && recentService.hasWords) {
            switch (section) {
            case 0:
                return "Favourites"
            case 1:
                return "Recents"
            default:
                return "Words"
            }
        } else if (favouriteService.hasFavourites && !recentService.hasWords) {
            switch (section) {
            case 0:
                return "Favourites"
            default:
                return "Words"
            }
        } else if (!favouriteService.hasFavourites && recentService.hasWords) {
            switch (section) {
            case 0:
                return "Recents"
            default:
                return "Words"
                
            }
        }
        else {
            return "Words"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var chosenString: String
        if (favouriteService.hasFavourites && recentService.hasWords)
        {
            switch (indexPath.section) {
            case 0:
                chosenString = favouriteService.words[indexPath.row]
            case 1:
                chosenString = recentService.words[indexPath.row]
            default:
                chosenString = self.searchResults[indexPath.row].word
            }
        } else if (favouriteService.hasFavourites && !recentService.hasWords) {
            switch (indexPath.section) {
            case 0:
                chosenString = favouriteService.words[indexPath.row]
            default:
                chosenString = self.searchResults[indexPath.row].word
            }
        } else if (!favouriteService.hasFavourites && recentService.hasWords) {
            switch (indexPath.section) {
            case 0:
                chosenString = recentService.words[indexPath.row]
            default:
                chosenString = self.searchResults[indexPath.row].word
            }
        } else if (!favouriteService.hasFavourites && !recentService.hasWords) {
            chosenString = self.searchResults[indexPath.row].word
        }
        else
        {
            chosenString = ""
        }
        
        if (chosenString != "") {
            chosenString = makeInflectionRequest(word: chosenString) ?? chosenString
            recentService.add(word: chosenString)
        }
        self.delegate?.searchTableViewControllerDidSelectResult(word: chosenString)
//        makeRequest(word: chosenString)
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
            
            //            self.coordinator?.showCard(word: word, exampleArray: examplesArray, definitionArray: definitionsArray)
            //            vc.etymologies = etymologiesArray.first        }
            
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



extension SearchTableViewController: UISearchResultsUpdating {
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
