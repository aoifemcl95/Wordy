//
//  SearchResult.swift
//  Wordy
//
//  Created by Aoife McLaughlin on 12/03/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//


import Foundation

struct SearchResults: Codable {
    let metadata: SearchMetadata?
    let results: [SearchResult]
}

struct SearchMetadata: Codable {
    let sourceLanguage, provider: String
    let limit, offset, total: Int
}

struct SearchResult: Codable {
    let word: String
    let id: String
    let score: Double
}




