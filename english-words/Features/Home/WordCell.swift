//
//  WordCell.swift
//  english-words
//
//  Created by Barış Dilekçi on 7.12.2024.
//

import UIKit

protocol WordCellProtocol: AnyObject {
    func didTapFavoriteButton(wordID: Int)
}

final class WordCell: UITableViewCell {
    static let identifier = "WordCell"
    weak var delegate: WordCellProtocol?
    private var wordID: Int?
    
    private let trLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let engLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(trLabel)
        contentView.addSubview(engLabel)
        contentView.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            trLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            trLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            engLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8),
            engLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    @objc private func favoriteButtonTapped() {
        guard let wordID = wordID else { return }
        delegate?.didTapFavoriteButton(wordID: wordID)
    }
    
    func configure(word: WordModel, isFavorite: Bool) {
        self.wordID = word.id
        trLabel.text = word.tr
        engLabel.text = word.eng
        favoriteButton.isSelected = isFavorite
    }
}
