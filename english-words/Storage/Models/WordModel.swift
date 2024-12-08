//
//  WordModel.swift
//  english-words
//
//  Created by Barış Dilekçi on 7.12.2024.
//

import Foundation

struct WordsResponse: Codable, Equatable {
    let words: [WordModel]
}

struct WordModel: Codable, Equatable {
    let id: Int
    let categoryId: Int
    let eng: String
    let tr: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryId
        case eng = "ENG"
        case tr = "TR"
    }
}
