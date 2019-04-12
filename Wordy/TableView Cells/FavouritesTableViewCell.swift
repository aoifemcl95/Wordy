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

        // Configure the view for the selected state
    }
    
}

extension FavouritesTableViewCell: UICollectionViewDelegate {
    
}

extension FavouritesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteService.words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentsCollectionViewCell", for: indexPath) as! RecentsCollectionViewCell
        
        cell.wordLabel.text = favouriteService.words[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectRecent(word: favouriteService.words[indexPath.item])
    }
    
    
}
