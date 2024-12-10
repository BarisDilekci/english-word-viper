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
    private var isSearching : Bool = false
    private var filteredWords: [WordModel] = []

    
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
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .gray
        return indicator
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for words"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()

    private lazy var filterButton: UIBarButtonItem = {
        let menu = UIMenu(title: "Filter Options", options: .displayInline, children: [
            UIAction(title: "Favorites", image: UIImage(systemName: "star.fill")) { _ in
                self.filterFavorites()
            },
            UIAction(title: "All Words", image: UIImage(systemName: "list.bullet")) { _ in
                self.showAllWords()
            }
        ])
        let button = UIBarButtonItem(
            image: UIImage(systemName: "line.horizontal.3.decrease.circle"),
            menu: menu
        )
        button.tintColor = .systemBlue
        return button
    }()

    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWordsFromJson()
        setupNavigationBar() 

    }

    // MARK: - UI Configuration
    private func setupUI() {
        searchBar.delegate = self
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
    private func setupNavigationBar() {
        navigationItem.title = "Words List"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.rightBarButtonItem = filterButton
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
    private func filterFavorites() {
        isSearching = true
        filteredWords = words.filter { favoriteWords.contains($0.id) }
        tableView.reloadData()
    }
    
    private func showAllWords() {
        isSearching = false
        filteredWords = []
        tableView.reloadData()
    }
    
   
}

//MARK: - UISearchBarDelegate
extension HomeViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         if searchText.isEmpty {
             isSearching = false
             filteredWords = []
         } else {
             isSearching = true
             filteredWords = words.filter {
                 $0.eng.localizedCaseInsensitiveContains(searchText) ||
                 $0.tr.localizedCaseInsensitiveContains(searchText)
             }
         }
         tableView.reloadData()
     }
}

// MARK: - UITableViewDelegate ve UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredWords.count : words.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCell.identifier, for: indexPath) as! WordCell
        let word = isSearching ? filteredWords[indexPath.row] : words[indexPath.row]
        
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

//#Preview {
//    HomeViewController()
//}
