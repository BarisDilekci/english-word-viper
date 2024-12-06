//
//  CoreDataDatabaseTests.swift
//  english-wordsTests
//
//  Created by Barış Dilekçi on 7.12.2024.
//

import XCTest
@testable import english_words

final class CoreDataDatabaseTests: XCTestCase {

    var database : CoreDataDatabase!
    
    override func setUp() {
        super.setUp()
        database = CoreDataDatabase(inMemory: true)
    }
    
    override func tearDown() {
            database = nil
            super.tearDown()
        }
    
    func testLoadFavoriteWords_Empty() {
        let favorites = database.loadFavoriteWords()
        XCTAssertTrue(favorites.isEmpty, "Favorites should be empty initially")
    }
    
    func testToggleFavorite_AddNewFavorite() {
        let wordID = Int.random(in: 1...10)
        database.toggleFavorite(id: wordID)
        
        let favorites = database.loadFavoriteWords()
        XCTAssertTrue(favorites.contains(wordID), "Favorites should contain the added word ID")

    }
    
    func testToggleFavorite_RemoveExistingFavorite() {
          let wordID = 1
          database.toggleFavorite(id: wordID)
          database.toggleFavorite(id: wordID)
          
          let favorites = database.loadFavoriteWords()
          XCTAssertFalse(favorites.contains(wordID), "Favorites should not contain the removed word ID")
      }
}
