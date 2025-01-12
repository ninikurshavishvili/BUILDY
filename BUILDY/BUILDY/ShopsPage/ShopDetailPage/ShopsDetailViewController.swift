//
//  ShopsDetailViewController.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 12.01.25.
//

import UIKit

class ShopDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var supplier: Suplier?
    private var filteredProducts: [Product] = []

    private let supplierNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let supplierLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 250)
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()

        if let supplier = supplier {
            supplierNameLabel.text = supplier.name
            loadImage(from: supplier.imageURL)
            loadProducts(for: supplier.name)
        }
    }

    private func setupUI() {
        view.addSubview(supplierLogoImageView)
        view.addSubview(supplierNameLabel)
        view.addSubview(productCollectionView)

        productCollectionView.register(ProductShopCell.self, forCellWithReuseIdentifier: ProductShopCell.identifier)
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
        NSLayoutConstraint.activate([
            supplierLogoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            supplierLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            supplierLogoImageView.widthAnchor.constraint(equalToConstant: 100),
            supplierLogoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            supplierNameLabel.topAnchor.constraint(equalTo: supplierLogoImageView.bottomAnchor, constant: 10),
            supplierNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            productCollectionView.topAnchor.constraint(equalTo: supplierNameLabel.bottomAnchor, constant: 20),
            productCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            productCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }

    private func loadImage(from urlString: String?) {
        guard let logoURL = urlString, let url = URL(string: logoURL) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.supplierLogoImageView.image = image
            }
        }.resume()
    }
    
    private func loadProducts(for supplierName: String) {
        let viewModel = HomePageViewModel()
        let allProducts = viewModel.products
        filteredProducts = viewModel.filteredBySupplier(for: supplierName, from: allProducts)
        productCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProducts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductShopCell.identifier, for: indexPath) as? ProductShopCell else {
            return UICollectionViewCell()
        }
        let product = filteredProducts[indexPath.item]
        cell.configure(with: product)
        return cell
    }
}
