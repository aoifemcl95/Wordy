//
//  Sense.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 08/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import Foundation

struct Sense: Codable {
    let definitions: [String]?
    let domains: [String]?
    let examples: [Example]?
    let id: String
    let shortDefinitions: [String]
    let subsenses: [Sense]?
    let thesaurusLinks: [ThesaurusLink]?
    let registers: [String]?
    let notes: [GrammaticalFeature]?
    let variantForms: [Example]?
    
    enum CodingKeys: String, CodingKey {
        case domains, examples, id, definitions
        case shortDefinitions = "short_definitions"
        case subsenses, thesaurusLinks, registers, notes, variantForms
    }
}
