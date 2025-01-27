//
//  ProductsContainerCell.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 13.01.25.
//


import UIKit

class ProductsContainerCell: UICollectionViewCell {

    static let reuseIdentifier = "ProductsContainerCell"

    private let productTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Products"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(productTitleLabel)
        contentView.addSubview(productsCollectionView)

        NSLayoutConstraint.activate([
            productTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            productTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            productsCollectionView.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: 30),
            productsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            productsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }

    func configure(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        productsCollectionView.delegate = delegate
        productsCollectionView.dataSource = dataSource
        productsCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
    }
}
