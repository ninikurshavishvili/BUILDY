//
//  SuplierContainerCell.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 11.01.25.
//

import UIKit

class SuplierContainerCell: UICollectionViewCell {
    static let identifier = "SuplierContainerCell"

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    private var products: [Product] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(logoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(productCollectionView)

        productCollectionView.register(ShopProductCell.self, forCellWithReuseIdentifier: ShopProductCell.identifier)
        productCollectionView.dataSource = self
        productCollectionView.delegate = self

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            logoImageView.heightAnchor.constraint(equalToConstant: 50),

            nameLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            productCollectionView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            productCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with supplier: Suplier, products: [Product]) {
        if let logoURL = supplier.imageURL, let url = URL(string: logoURL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let self = self, let data = data, error == nil, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.logoImageView.image = image
                }
            }.resume()
        } else {
            logoImageView.image = UIImage(systemName: "photo")
        }
        nameLabel.text = supplier.name

        self.products = products
        productCollectionView.reloadData()
    }
}

extension SuplierContainerCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopProductCell.identifier, for: indexPath) as? ShopProductCell else {
            return UICollectionViewCell()
        }
        let product = products[indexPath.item]
        cell.configure(with: product)
        return cell
    }
}





