//
//  AppContainer.swift
//  english-words
//
//  Created by Barış Dilekçi on 6.12.2024.
//

import Swinject
import Foundation

final class AppContainer {
    
    static let shared = AppContainer()
    
    private let container : Container
    
    private init () {
        container = Container()
    }
    
    private func registerDependencies() {
        container.register(LocalDatabaseProtocol.self) { _ in
            CoreDataDatabase.shared
        }.inObjectScope(.container)
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
           return container.resolve(type)
       }
}
