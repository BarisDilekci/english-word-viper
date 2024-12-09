//
//  HomePresenterTests.swift
//  english-wordsTests
//
//  Created by Barış Dilekçi on 8.12.2024.
//

import XCTest
@testable import english_words

final class HomePresenterTests: XCTestCase {

    var presenter: HomePresenter!
    var mockView: MockHomeView!
    var mockInteractor: MockHomeInteractor!
    
    override func setUp() {
        super.setUp()
        
        mockView = MockHomeView()
        mockInteractor = MockHomeInteractor()
        presenter = HomePresenter()
        
        presenter.view = mockView
        presenter.interactor = mockInteractor
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        
        super.tearDown()
    }

    func testShowWords() {
        let words = [WordModel(id: 1, categoryId: 1, eng: "Hello", tr: "Merhaba")]
        
        presenter.view?.showWords(words)
        
        XCTAssertTrue(mockView.isShowWordsCalled)
        XCTAssertEqual(mockView.words, words)
    }

    func testShowError() {
        let errorMessage = "Failed to fetch words"
        
        presenter.view?.showError(errorMessage)
        
        XCTAssertTrue(mockView.isShowErrorCalled)
        XCTAssertEqual(mockView.errorMessage, errorMessage)
    }
}

class MockHomeView: PresenterToViewHomeProtocol {
    var isShowWordsCalled = false
    var isShowErrorCalled = false
    var words: [WordModel] = []
    var errorMessage: String = ""
    
    func updateFavoriteButton(isFavorite: Bool) {}
    
    func showWords(_ words: [WordModel]) {
        isShowWordsCalled = true
        self.words = words
    }
    
    func showError(_ message: String) {
        isShowErrorCalled = true
        self.errorMessage = message
    }
}

class MockHomeInteractor: PresenterToInteractorHomeProtocol {
    var presenter: InteractorToPresenterHomeProtocol?
    
    func toggleFavorite(id: Int) {}
    
    func fetchWordsFromLocalJson() {
        let words = [WordModel(id: 1, categoryId: 1, eng: "Hello", tr: "Merhaba")]
        presenter?.didFetchWords(words)
    }
}
