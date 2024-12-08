//
//  HomeView.swift
//  english-words
//
//  Created by Barış Dilekçi on 7.12.2024.
//
import UIKit

final class HomeView: BaseView<HomeViewController> {
    
    // MARK: - Properties
    weak var presenter: ViewToPresenterHomeProtocol?
    
    // MARK: - UI Components
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WordCell.self, forCellReuseIdentifier: WordCell.identifier)
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    // MARK: - Setup Methods
    override func setupView() {
        super.setupView()
        setupConstraints()
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(tableView)  // TableView'ı görünüm hiyerarşisine ekliyoruz
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // TableView'ı safe area'ya yerleştiriyoruz
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),  // Safe Area
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }


    
    func layoutData() {
        tableView.reloadData()
    }
    
    func setTableViewDelegate(_ delegate: UITableViewDelegate & UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = delegate
    }
}
