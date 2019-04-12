//
//  DetailViewController.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 08/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

//    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var word: String?
    var etymologies: [String]?
    var definitionArray: [[String]]?
    var exampleArray: [[Example]]?
    let favouriteService = FavouriteService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName:"WordCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WordCollectionViewCellIdentifier")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.favouriteButton.tintColor = UIColor(red: 1.0, green: 0.784, blue: 0.2, alpha: 1.0)
        
        
        guard let word = word else {return}
        makeRequest(word: word)
        let isFavourited = favouriteService.isFavourited(word: word)
        if (isFavourited) {
            setButtonImageFavourited()
        }
        else {
             setButtonImageUnfavourited()
        }
    }

    init(word:String) {
        self.word = word
        super.init(nibName: "DetailViewController", bundle: nil)
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
       
        collectionView.reloadData()
        subtitleLabel.text = etymologies?.first
    }
    
    func makeRequest(word: String) {
        let urlService = URLService()
        urlService.fetchWords(word: word) { (results) in
            self.gotResults(results: results)
            self.setupView()
            
        }
    }
    
    func gotResults(results: [Result]?) {
        var derivativeArray = [String]()
        var definitionsArray = [[String]]()
        var examplesArray = [[Example]]()
        var etymologiesArray = [[String]]()
        var shortDefs = [String]()
        if let lexicalEntries = results?.first?.lexicalEntries {
            for lexicalEntry in lexicalEntries {
                if let derivatives = lexicalEntry.derivatives {
                    for derivative in derivatives {
                        derivativeArray.append(derivative.text)
                    }
                }
                let entries = lexicalEntry.entries
                for entry in entries {
                    
                    guard let senses = entry.senses else { return }
                    for sense in senses {
                        if let definitions = sense.definitions
                        {
                            definitionsArray.append(definitions)
                            if let examples = sense.examples {
                                examplesArray.append(examples)
                                guard let shortDefinitions = sense.shortDefinitions else { return }
                                for shortDef in shortDefinitions {
                                    shortDefs.append(shortDef)
                                }
                            }
                        }
                    }
                }
            }
        }
        self.definitionArray = definitionsArray
        self.exampleArray = examplesArray
        collectionView.reloadData()
    }
    
    func setButtonImageFavourited()
    {
        self.favouriteButton.setImage(UIImage.init(named: "fav"), for: .normal)
    }
    
    func setButtonImageUnfavourited()
    {
        self.favouriteButton.setImage(UIImage.init(named:"unfav"), for: .normal)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let definitionArray = self.definitionArray {
            return definitionArray.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WordCollectionViewCellIdentifier", for: indexPath) as! WordCollectionViewCell
        var exampleString = ""
        var definitionString = ""
        if let exampleArray = self.exampleArray {
            if (exampleArray.count > indexPath.item) {
                let example = exampleArray[indexPath.item]
                exampleString = "Examples \n"
                    for i in 0 ..< example.count {
                        let string = "\(i+1). \(example[i].text.capitalizingFirstLetter())"
                        
                        
                        exampleString.append("\(string)\n")
                    }
                if let word = word {
                    let boldAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: cell.exampleLabel.font.pointSize)]
                    let attrString = NSMutableAttributedString(string: word, attributes: boldAttr)
                }
                cell.exampleLabel.text = exampleString
            }
            else
            {
                cell.exampleView.alpha = 0;
            }
        }
        

        guard let definition = self.definitionArray?[indexPath.item] else { return cell }
                for i in 0 ..< definition.count {
                    let string = "\(definition[i].capitalizingFirstLetter())"
                    definitionString.append("\(string)\n")
                }
        
        cell.definitionLabel.font = UIFont.boldSystemFont(ofSize: 17)
        cell.definitionLabel.text = definitionString
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionView.bounds.size
    }
    
    @IBAction func favouriteTapped(_ sender: Any) {
        guard let word = word else { return }
        if (favouriteService.isFavourited(word: word)) {
            favouriteService.removeFavourite(word: word)
            self.setButtonImageUnfavourited()
        }
        else
        {
            self.setButtonImageFavourited()
            favouriteService.addFavourite(word: word)
        }
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
