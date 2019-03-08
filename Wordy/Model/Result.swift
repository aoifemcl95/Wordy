//
//  File.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 08/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import Foundation

struct Result: Codable {
    let id, language: String
    let lexicalEntries: [LexicalEntry]
    let type, word : String
}
