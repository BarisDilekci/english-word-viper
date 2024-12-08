//
//  LocalDatabase.swift
//  english-words
//
//  Created by Barış Dilekçi on 6.12.2024.
//

import Foundation

protocol LocalDatabaseProtocol {
    func loadFavoriteWords() -> Set<Int>
    func toggleFavorite(id : Int) -> Bool
}
