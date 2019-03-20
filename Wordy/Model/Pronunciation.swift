//
//  Pronunciation.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 08/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import Foundation

struct Pronunciation: Codable {
    let audioFile: String?
    let dialects: [String]?
    let phoneticNotation, phoneticSpelling: String?
}
