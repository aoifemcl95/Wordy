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
        NotificationCenter.default.addObserver(self, selector: #selector(favouriteAdded), name: Notification.Name("FavouriteAdded"), object: nil)
        super.viewDidLoad()
        let recentCellNib = UINib(nibName: "RecentsTableViewCell", bundle: nil)
        let favouriteCellNib = UINib(nibName: "FavouritesTableViewCell", bundle: nil)
        tableView.register(recentCellNib, forCellReuseIdentifier: "RecentsTableViewCell")
        tableView.register(favouriteCellNib, forCellReuseIdentifier: "FavouritesTableViewCell")
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Words"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Recents"
        } else {
            return "Favourites"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentsTableViewCell", for: indexPath) as! RecentsTableViewCell
            cell.userInteractionEnabledWhileDragging = false
            cell.delegate = self
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesTableViewCell", for: indexPath) as! FavouritesTableViewCell
            cell.userInteractionEnabledWhileDragging = false
            cell.delegate = self
            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    @objc func favouriteAdded() {
        tableView.reloadInputViews()
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
