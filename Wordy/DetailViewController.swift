//
//  DetailViewController.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 08/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var word: String?
    var definitionArray: [String]
    var exampleArray: [Example]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName:"WordCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WordCollectionViewCellIdentifier")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.roundedCorners(cornerRadius: 15.0)
        self.collectionView.backgroundColor = UIColor(red: 1.0, green: 0.784, blue: 0.2, alpha: 1.0)
        setupView()
    }
    
    init(exampleArray: [Example]?, definitionArray: [String]) {
        self.exampleArray = exampleArray
        self.definitionArray = definitionArray
        super.init(nibName:"DetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        cardView.roundedCorners(cornerRadius: 20.0)
        cardView.backgroundColor = UIColor.white
        cardView.layer.borderColor = UIColor(red: 1.0, green: 0.784, blue: 0.2, alpha: 1.0).cgColor
        cardView.layer.borderWidth = 2.5
        word?.capitalizeFirstLetter()
        wordLabel.text = word
//        guard let shortDef = shortDefinition else { return }
        
        wordLabel.textColor = UIColor(red: 1.0, green: 0.784, blue: 0.2, alpha: 1.0)
        wordLabel.font.withSize(25)
        wordLabel.layer.masksToBounds = true
        wordLabel.layer.cornerRadius = 5.0
       
        
        
//        guard let example = example else { return }
//        exampleLabel.text = "Example: \(example.text)"
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.definitionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WordCollectionViewCellIdentifier", for: indexPath) as! WordCollectionViewCell
        
        //in this example I added a label named "title" into the MyCollectionCell class
        if let exampleArray = self.exampleArray {
            if (exampleArray.count > indexPath.item) {
                cell.exampleLabel.text = exampleArray[indexPath.item].text.capitalizingFirstLetter()
            }
            else
            {
                cell.exampleLabel.text = "";
            }
        }
        

        cell.definitionLabel.text = self.definitionArray[indexPath.item].capitalizingFirstLetter()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionView.bounds.size
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

extension UIView {
    func roundedCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
    }
}
