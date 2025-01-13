//
//  CategoriesContainerCell.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 13.01.25.
//

import UIKit

class CategoriesContainerCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CategoriesContainerCell"

    private let categoriesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    var onSeeAllTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        seeAllButton.addTarget(self, action: #selector(seeAllTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(categoriesTitleLabel)
        contentView.addSubview(seeAllButton)
        contentView.addSubview(categoriesCollectionView)

        NSLayoutConstraint.activate([
            categoriesTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoriesTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            seeAllButton.centerYAnchor.constraint(equalTo: categoriesTitleLabel.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            categoriesCollectionView.topAnchor.constraint(equalTo: categoriesTitleLabel.bottomAnchor, constant: 8),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    func configure(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource, onSeeAllTapped: @escaping () -> Void) {
        self.onSeeAllTapped = onSeeAllTapped
        categoriesCollectionView.delegate = delegate
        categoriesCollectionView.dataSource = dataSource
        categoriesCollectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identifier)
    }

    @objc private func seeAllTapped() {
        onSeeAllTapped?()
    }
}

