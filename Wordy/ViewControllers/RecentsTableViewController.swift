//
//  RecentsTableViewController.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 26/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

protocol RecentsTableViewControllerDelegate: class {
    func didReceiveDelegateMethod(word: String)
}

class RecentsTableViewController: UITableViewController {

    weak var delegate: RecentsTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customCellNib = UINib(nibName: "RecentsTableViewCell", bundle: nil)
        tableView.register(customCellNib, forCellReuseIdentifier: "RecentsTableViewCell")
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Words"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recents"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentsTableViewCell", for: indexPath) as! RecentsTableViewCell
        cell.userInteractionEnabledWhileDragging = false
        cell.delegate = self
            return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}

extension RecentsTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}

extension RecentsTableViewController: RecentsTableViewCellDelegate {
    func didSelectRecent(word: String) {
        delegate?.didReceiveDelegateMethod(word: word)
    }
}
