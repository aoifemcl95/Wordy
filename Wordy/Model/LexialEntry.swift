//
//  LexialEntries.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 08/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import Foundation

struct LexicalEntry: Codable {
    let derivatives: [Derivative]?
    let entries: [Entry]
    let text: String
    let language, lexicalCategory : String
    let pronunciations: [Pronunciation]?
}
