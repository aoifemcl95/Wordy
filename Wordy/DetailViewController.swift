//
//  DetailViewController.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 08/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    
    var word: String?
    var shortDefinition: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }

    
    func setupView() {
        cardView.layer.cornerRadius = 5.0
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.5
        
        let shadowPath = UIBezierPath(roundedRect: self.view.bounds, cornerRadius: 5.0)
        cardView.layer.shadowPath = shadowPath.cgPath
        
        word?.capitalizeFirstLetter()
        wordLabel.text = word
        guard let shortDef = shortDefinition else { return }
        
        wordLabel.textColor = UIColor.black
        wordLabel.font.withSize(25)
        wordLabel.layer.masksToBounds = true
        wordLabel.layer.cornerRadius = 5.0
        definitionLabel.text = (shortDefinition != nil) ? "Definition: \(shortDef)" : "Sorry we can't find a definition for that word"
        definitionLabel.textColor = UIColor.black
        definitionLabel.layer.masksToBounds = true
        definitionLabel.layer.cornerRadius = 5.0
    }

    


}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
