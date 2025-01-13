//
//  SuplierContainerCell.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 11.01.25.
//

import UIKit

class SuplierContainerCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static let identifier = "SuplierContainerCell"

    private let suplierCellView: SuplierCellView = {
        let view = SuplierCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    private var supplier: Suplier?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(suplierCellView)
        contentView.addSubview(productCollectionView)

        productCollectionView.register(ShopProductCell.self, forCellWithReuseIdentifier: ShopProductCell.identifier)
        productCollectionView.dataSource = self
        productCollectionView.delegate = self

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        suplierCellView.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            suplierCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            suplierCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            suplierCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            suplierCellView.heightAnchor.constraint(equalToConstant: 66),

            productCollectionView.topAnchor.constraint(equalTo: suplierCellView.bottomAnchor, constant: 16),
            productCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func handleTap() {
        guard let supplier = supplier else { return }
        navigateToShopDetails(for: supplier)
    }

    func configure(with supplier: Suplier, products: [Product]) {
        self.supplier = supplier
        suplierCellView.configure(with: supplier)
        self.products = products
        productCollectionView.reloadData()
    }

    private func navigateToShopDetails(for supplier: Suplier) {
        if let viewController = self.viewController() {
            let shopDetailsVC = ShopDetailsViewController()
            shopDetailsVC.supplier = supplier
            viewController.navigationController?.pushViewController(shopDetailsVC, animated: true)
        }
    }
}

extension SuplierContainerCell {
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
}
