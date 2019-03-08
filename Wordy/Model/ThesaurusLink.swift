//
//  ThesaurausLink.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 08/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import Foundation

struct ThesaurusLink: Codable {
    let entryID, senseID: String
    
    enum CodingKeys: String, CodingKey {
        case entryID = "entry_id"
        case senseID = "sense_id"
    }
    
}
