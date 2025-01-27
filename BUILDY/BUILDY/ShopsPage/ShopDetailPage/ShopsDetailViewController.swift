//
//  ShopsDetailViewController.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 12.01.25.
//

import UIKit
import SwiftUI

final class ShopDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var supplier: Suplier?
    private var filteredProducts: [Product] = []
    private let navigationHandler = ShopDetailsNavigationHandler()
    
    private let customTopBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .prominent
        
        let textField = searchBar.searchTextField
        textField.backgroundColor = .clear
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: placeholderAttributes)
        
        textField.leftView?.tintColor = .gray
        textField.clearButtonMode = .whileEditing
        textField.textAlignment = .left
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = UIScreen.main.bounds.width / 2 - 24
        layout.itemSize = CGSize(width: itemWidth, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupUI()
        searchBar.delegate = self
        
        if let supplier = supplier {
            loadProducts(for: supplier.name)
        }
    }
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(didTapBackButton)
        )
        backButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = searchBar
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        view.addSubview(customTopBar)
        customTopBar.addSubview(searchBar)
        view.addSubview(productCollectionView)
        
        productCollectionView.register(ProductShopCell.self, forCellWithReuseIdentifier: ProductShopCell.identifier)
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
        NSLayoutConstraint.activate([
            customTopBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customTopBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTopBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTopBar.heightAnchor.constraint(equalToConstant: 56),
            
            searchBar.leadingAnchor.constraint(equalTo: customTopBar.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: customTopBar.trailingAnchor, constant: -16),
            searchBar.centerYAnchor.constraint(equalTo: customTopBar.centerYAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            
            productCollectionView.topAnchor.constraint(equalTo: customTopBar.bottomAnchor, constant: 16),
            productCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = filteredProducts[indexPath.item]
        navigationHandler.navigateToProductDetails(from: self, with: selectedProduct)
    }

    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let supplierName = supplier?.name else { return }
        let viewModel = HomePageViewModel()
        let allProducts = viewModel.products
        filteredProducts = viewModel.filteredBySupplier(for: supplierName, from: allProducts).filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
        productCollectionView.reloadData()
    }
}

