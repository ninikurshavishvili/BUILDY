//
//  ProductCategoryViewController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 10.01.25.
//

import UIKit

class CategoryDetailViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        return collectionView
    }()
    
    private var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        view.backgroundColor = .systemGroupedBackground
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCategoryCell.self, forCellWithReuseIdentifier: ProductCategoryCell.identifier)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configure(with products: [Product]) {
        self.products = products
        print("Configured with \(products.count) products")
        for product in products {
            print("Product - Name: \(product.name), Category: \(product.category)")
        }
        collectionView.reloadData()
    }

}

extension CategoryDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCategoryCell.identifier, for: indexPath) as? ProductCategoryCell else {
            return UICollectionViewCell()
        }
        let product = products[indexPath.row]
        print("Displaying product: \(product.name)")
        cell.configure(with: product)
        return cell
    }

}
