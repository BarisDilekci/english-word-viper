//
//  HomeInteractor.swift
//  english-words
//
//  Created by Barış Dilekçi on 6.12.2024.
//  
//

import Foundation

class HomeInteractor: PresenterToInteractorHomeProtocol {

    var words : [WordModel] = []
    var presenter: InteractorToPresenterHomeProtocol?
    private let coreDataManager: CoreDataDatabase

    init(coreDataManager: CoreDataDatabase) {
        self.coreDataManager = coreDataManager
    }

    func toggleFavorite(id: Int) {
        let isFavorite = coreDataManager.toggleFavorite(id: id)
        presenter?.didTapOnFavoriteButton(isFavorite: isFavorite)
    }
    
    func fetchWordsFromLocalJson() {
        // `decode` metodu kullanılacaksa dosyayı direkt decode etmeliyiz
        guard let response: WordsResponse = Bundle.main.decode("word.json") else {
            presenter?.didFailToFetchWords(with: "JSON file not found!")
            return
        }
        
        // JSON'dan decode edilmiş `WordsResponse` nesnesindeki `words` listesi Presenter'a iletiliyor
        presenter?.didFetchWords(response.words)
    }


}
