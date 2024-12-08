//
//  HomeViewController.swift
//  english-words
//
//  Created by Barış Dilekçi on 6.12.2024.
//  
//

import UIKit

final class HomeViewController: UIViewController, WordCellProtocol {

    // MARK: - Properties
    var presenter: ViewToPresenterHomeProtocol?
    private var words: [WordModel] = []
    private var favoriteWords: Set<Int> = []
    
    // MARK: - UI Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WordCell.self, forCellReuseIdentifier: WordCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // Loading indicator
    private var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .gray
        return indicator
    }()
    
    // Search bar
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for words"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWordsFromJson()
    }

    // MARK: - UI Configuration
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func loadWordsFromJson() {
        loadingIndicator.startAnimating()
        presenter?.interactor?.fetchWordsFromLocalJson()
    }
    
    // MARK: - WordCellProtocol Implementation
    func didTapFavoriteButton(wordID: Int) {
        toggleFavoriteStatus(for: wordID)
        tableView.reloadData()
    }

    private func toggleFavoriteStatus(for wordID: Int) {
        if favoriteWords.contains(wordID) {
            favoriteWords.remove(wordID)
        } else {
            favoriteWords.insert(wordID)
        }
    }
}

// MARK: - UITableViewDelegate ve UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCell.identifier, for: indexPath) as! WordCell
        let word = words[indexPath.row]
        
        cell.configure(word: word, isFavorite: favoriteWords.contains(word.id))
        cell.delegate = self
        
        return cell
    }
}

// MARK: - PresenterToViewHomeProtocol Implementation
extension HomeViewController: PresenterToViewHomeProtocol {
    
    func showWords(_ words: [WordModel]) {
        self.words = words
        tableView.reloadData()
        loadingIndicator.stopAnimating()
    }
    
    func showError(_ message: String) {
        loadingIndicator.stopAnimating()
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func updateFavoriteButton(isFavorite: Bool) {
        print(isFavorite)
    }
}
