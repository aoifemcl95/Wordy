//
//  RecentsTableViewCell.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 26/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class RecentsTableViewCell: UITableViewCell {

    var layout: LoopLayout!
    let recentService = RecentService()
    @IBOutlet weak var collectionView: UICollectionView!
    
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

extension RecentsTableViewCell: UICollectionViewDelegate {
    
}

extension RecentsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return recentService.words.count
        return 20
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentsCollectionViewCell", for: indexPath) as! RecentsCollectionViewCell
        
//        cell.wordLabel.text = recentService.words[indexPath.item]
        cell.wordLabel.text = "Loopy"
        return cell
    }
    
    
}
