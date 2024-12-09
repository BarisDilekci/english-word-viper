//
//  HomeInteractorTest.swift
//  english-wordsTests
//
//  Created by Barış Dilekçi on 10.12.2024.
//

import XCTest
@testable import english_words

final class HomeInteractorTest: XCTestCase {
    
    var interactor : MockHomeInteractor!
    var mockPresenter : MockPresenter!
    
    override func setUp() {
        super.setUp()
        interactor = MockHomeInteractor()
        mockPresenter = MockPresenter()
        interactor.presenter = mockPresenter
    }
    
    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    func testFetchWordsFromLocalJson() {
        interactor.fetchWordsFromLocalJson()
        
        XCTAssertTrue(mockPresenter.isDidFetchWordsCalled, "Presenter'ın didFetchWords metodu çağrılmadı.")
        
        XCTAssertEqual(mockPresenter.fetchedWords.count, 1, "Presenter'a gönderilen kelime sayısı yanlış.")
        XCTAssertEqual(mockPresenter.fetchedWords.first?.eng, "Hello", "Presenter'a gönderilen kelimenin 'eng' değeri yanlış.")
        XCTAssertEqual(mockPresenter.fetchedWords.first?.tr, "Merhaba", "Presenter'a gönderilen kelimenin 'tr' değeri yanlış.")
    }
    
}

class MockPresenter: InteractorToPresenterHomeProtocol {
    var isDidFetchWordsCalled = false
    var fetchedWords: [WordModel] = []
    var fetchErrorMessage: String?
    
    func didFetchWords(_ words: [WordModel]) {
        isDidFetchWordsCalled = true
        fetchedWords = words
    }
    
    func didFailToFetchWords(with error: String) {
        fetchErrorMessage = error
    }
    
    func didTapOnFavoriteButton(isFavorite: Bool) {}
}
