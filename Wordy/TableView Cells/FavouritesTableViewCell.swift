//
//  FavouritesTableViewCell.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 12/04/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var layout: LoopLayout!
    let favouriteService = FavouriteService()
    weak var delegate: RecentsTableViewCellDelegate?
    
    override func awakeFromNib() {
        NotificationCenter.default.addObserver(self, selector: #selector(favouriteAdded), name:.favouritesChanged, object: nil)
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        let collectionViewCellNib = UINib.init(nibName: "RecentsCollectionViewCell", bundle: nil)
        collectionView.register(collectionViewCellNib, forCellWithReuseIdentifier: "RecentsCollectionViewCell")
        let layout = LoopLayout()
        collectionView.collectionViewLayout = layout
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func favouriteAdded() {
        collectionView.reloadSections([0])
    }
    
}

extension FavouritesTableViewCell: UICollectionViewDelegate {
    
}

extension FavouritesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.favouriteService.words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentsCollectionViewCell", for: indexPath) as! RecentsCollectionViewCell
        let word = self.favouriteService.words[indexPath.item]
        
        cell.wordLabel.text = word
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectRecent(word: self.favouriteService.words[indexPath.item])
    }
    
    
}
