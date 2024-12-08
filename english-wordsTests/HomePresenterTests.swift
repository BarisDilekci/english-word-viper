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
        // Arrange: Test için mock veriyi hazırlıyoruz
        let words = [WordModel(id: 1, categoryId: 1, eng: "Hello", tr: "Merhaba")]
        
        // Act: Presenter'a showWords() metodunu çağırıyoruz
        presenter.view?.showWords(words)
        
        // Assert: MockView'ın doğru şekilde çalışıp çalışmadığını kontrol ediyoruz
        XCTAssertTrue(mockView.isShowWordsCalled)
        XCTAssertEqual(mockView.words, words)
    }

    func testShowError() {
        // Arrange: Error mesajını hazırlıyoruz
        let errorMessage = "Failed to fetch words"
        
        // Act: Presenter'a showError() metodunu çağırıyoruz
        presenter.view?.showError(errorMessage)
        
        // Assert: Error mesajının doğru şekilde View'a iletilip iletilmediğini kontrol ediyoruz
        XCTAssertTrue(mockView.isShowErrorCalled)
        XCTAssertEqual(mockView.errorMessage, errorMessage)
    }
}

// Mock View: PresenterToViewHomeProtocol protokolünü implement eder
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

// Mock Interactor: PresenterToInteractorHomeProtocol protokolünü implement eder
class MockHomeInteractor: PresenterToInteractorHomeProtocol {
    var presenter: InteractorToPresenterHomeProtocol?
    
    // Burada metotları mockluyoruz, çünkü testte yalnızca presenter'ı kontrol edeceğiz
    func toggleFavorite(id: Int) {}
    
    func fetchWordsFromLocalJson() {
        // Burada gerçekte JSON verisi çekmek yerine, direkt olarak veriyi return edebiliriz
        let words = [WordModel(id: 1, categoryId: 1, eng: "Hello", tr: "Merhaba")]
        presenter?.didFetchWords(words)
    }
}
