//
//  HomeContract.swift
//  english-words
//
//  Created by Barış Dilekçi on 6.12.2024.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewHomeProtocol : AnyObject {
    func updateFavoriteButton(isFavorite: Bool)
    func showWords(_ words: [WordModel]) 
    func showError(_ message: String)

}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterHomeProtocol : AnyObject {
    
    var view: PresenterToViewHomeProtocol? { get set }
    var interactor: PresenterToInteractorHomeProtocol? { get set }
    var router: PresenterToRouterHomeProtocol? { get set }
    
    func didTapOnFavoriteButton(id: Int)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorHomeProtocol {
    var presenter: InteractorToPresenterHomeProtocol? { get set }
    func toggleFavorite(id: Int)
    func fetchWordsFromLocalJson()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterHomeProtocol: AnyObject {
    func didTapOnFavoriteButton(isFavorite: Bool)
    func didFetchWords(_ words: [WordModel])
    func didFailToFetchWords(with error: String)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterHomeProtocol {
    
}
