//
//  ShopContainerCell.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 22.01.25.
//

import UIKit

class ShopsContainerCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ShopsContainerCell"

    private let shopsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Shops"
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

    let shopsCollectionView: UICollectionView = {
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
        contentView.addSubview(shopsTitleLabel)
        contentView.addSubview(seeAllButton)
        contentView.addSubview(shopsCollectionView)

        NSLayoutConstraint.activate([
            shopsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            shopsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            seeAllButton.centerYAnchor.constraint(equalTo: shopsTitleLabel.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            shopsCollectionView.topAnchor.constraint(equalTo: shopsTitleLabel.bottomAnchor, constant: 8),
            shopsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shopsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            shopsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shopsCollectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    func configure(delegate: UICollectionViewDelegate,
                   dataSource: UICollectionViewDataSource,
                   onSeeAllTapped: @escaping () -> Void) {
        self.onSeeAllTapped = onSeeAllTapped
        shopsCollectionView.delegate = delegate
        shopsCollectionView.dataSource = dataSource
        shopsCollectionView.register(ShopCell.self, forCellWithReuseIdentifier: ShopCell.identifier)
    }

    @objc private func seeAllTapped() {
        onSeeAllTapped?()
    }
}



