//
//  HomePresenter.swift
//  english-words
//
//  Created by Barış Dilekçi on 6.12.2024.
//  
//

class HomePresenter: ViewToPresenterHomeProtocol {
    
    // MARK: - Properties
    var view: PresenterToViewHomeProtocol?
    var interactor: PresenterToInteractorHomeProtocol?
    var router: PresenterToRouterHomeProtocol?
    
    func didTapOnFavoriteButton(id: Int) {
        interactor?.toggleFavorite(id: id)
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    func didFetchWords(_ words: [WordModel]) {
        view?.showWords(words)
    }
    
    func didFailToFetchWords(with error: String) {
        print("error")
    }
    
    func didTapOnFavoriteButton(isFavorite: Bool) {
        view?.updateFavoriteButton(isFavorite: isFavorite) 
    }
}
