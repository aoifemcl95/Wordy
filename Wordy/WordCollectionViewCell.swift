//
//  WordCollectionViewCell.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 13/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class WordCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var definitionLabel: UILabel!
    
    @IBOutlet weak var exampleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        definitionLabel.roundedCorners(cornerRadius: 2.0)
        definitionLabel.backgroundColor = UIColor.lightGray
        
        
        exampleLabel.roundedCorners(cornerRadius: 2.0)
        exampleLabel.backgroundColor = UIColor.lightGray
        // Initialization code
    }

}
