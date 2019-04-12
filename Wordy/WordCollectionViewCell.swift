//
//  WordCollectionViewCell.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 13/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class WordCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var exampleView: UIView!
    @IBOutlet weak var definitionView: UIView!
    @IBOutlet weak var definitionLabel: UILabel!
    
    @IBOutlet weak var exampleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        definitionView.roundedCorners(cornerRadius: 2.0)
        definitionLabel.textColor = UIColor.darkGray
        definitionLabel.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        
        
        exampleView.roundedCorners(cornerRadius: 2.0)
        exampleLabel.textColor = UIColor.black
        // Initialization code
    }

}
