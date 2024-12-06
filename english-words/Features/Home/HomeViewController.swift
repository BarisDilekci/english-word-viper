//
//  HomeViewController.swift
//  english-words
//
//  Created by Barış Dilekçi on 6.12.2024.
//  
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterHomeProtocol?
    
}

extension HomeViewController: PresenterToViewHomeProtocol{
    // TODO: Implement View Output Methods
}
