//
//  HomeRouter.swift
//  english-words
//
//  Created by Barış Dilekçi on 6.12.2024.
//  
//

import Foundation
import UIKit

class HomeRouter: PresenterToRouterHomeProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = HomeViewController()
        
        let presenter: ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol = HomePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = HomeRouter()
        viewController.presenter?.view = viewController 
        viewController.presenter?.interactor = HomeInteractor(coreDataManager: CoreDataDatabase())
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
