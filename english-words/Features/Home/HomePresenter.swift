//
//  HomePresenter.swift
//  english-words
//
//  Created by Barış Dilekçi on 6.12.2024.
//  
//

import Foundation

class HomePresenter: ViewToPresenterHomeProtocol {

    // MARK: Properties
    var view: PresenterToViewHomeProtocol?
    var interactor: PresenterToInteractorHomeProtocol?
    var router: PresenterToRouterHomeProtocol?
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    
}
