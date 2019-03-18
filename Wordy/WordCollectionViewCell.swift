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
        definitionLabel.textColor = UIColor.white
        definitionView.backgroundColor = UIColor.init(red: 81/255, green: 216/255, blue: 249/255, alpha: 1.0)
        
        
        exampleView.roundedCorners(cornerRadius: 2.0)
        exampleLabel.textColor = UIColor.white
        exampleView.backgroundColor = UIColor.init(red: 173/255, green: 147/255, blue: 253/255, alpha: 1.0)
        // Initialization code
    }

}
