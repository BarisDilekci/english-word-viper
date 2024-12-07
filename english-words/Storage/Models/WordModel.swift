//
//  WordModel.swift
//  english-words
//
//  Created by Barış Dilekçi on 7.12.2024.
//

import Foundation

struct WordList: Codable {
    let words: [Word]
}

struct Word: Codable {
    let id: Int
    let categoryId: Int
    let ENG: String
    let TR: String
}
