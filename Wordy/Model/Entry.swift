//
//  Entries.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 08/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import Foundation

struct Entry: Codable {
    let etymologies: [String]?
    let grammaticalFeatures: [GrammaticalFeature]?
    let homographNumber: String
    let senses: [Sense]?
}
