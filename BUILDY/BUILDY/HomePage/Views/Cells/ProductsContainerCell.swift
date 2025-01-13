//
//  ProductsContainerCell.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 13.01.25.
//


import UIKit

class ProductsContainerCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ProductsContainerCell"

    let productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
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
        contentView.addSubview(productsCollectionView)

        NSLayoutConstraint.activate([
            productsCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        productsCollectionView.delegate = delegate
        productsCollectionView.dataSource = dataSource
        productsCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
    }
}
