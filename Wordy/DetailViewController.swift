//
//  DetailViewController.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 08/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
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
        word?.capitalizeFirstLetter()
        wordLabel.text = word
        guard let shortDef = shortDefinition else { return }
        
        wordLabel.backgroundColor = UIColor.lightGray
        wordLabel.textColor = UIColor.white
        wordLabel.layer.masksToBounds = true
        wordLabel.layer.cornerRadius = 5.0
        definitionLabel.text = "Definition: \(shortDef)"
        definitionLabel.textColor = UIColor.white
        definitionLabel.layer.masksToBounds = true
        definitionLabel.backgroundColor = UIColor.lightGray
        definitionLabel.layer.cornerRadius = 5.0
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
