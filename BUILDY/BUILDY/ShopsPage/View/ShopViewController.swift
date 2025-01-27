//
//  ShopsViewController.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 11.01.25.
//

import UIKit

class ShopViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    private let viewModel = ShopViewModel()
    private var filteredManufacturers: [Suplier] = []
    private let homePageViewModel = HomePageViewModel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 300)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
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

    private let navigationHandler = ShopPageNavigationHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupCollectionView()
        
        viewModel.onSuppliersFetched = { [weak self] in
            guard let self = self else { return }
            self.filteredManufacturers = self.viewModel.suppliers
            self.collectionView.reloadData()
        }
        
        viewModel.fetchSuppliers()
    }

    private func setupSearchBar() {
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        searchBar.delegate = self
    }

    private func setupCollectionView() {
        collectionView.register(SuplierContainerCell.self, forCellWithReuseIdentifier: SuplierContainerCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterSuppliers(for: searchText) { [weak self] filteredSuppliers in
            self?.filteredManufacturers = filteredSuppliers
            self?.collectionView.reloadData()
        }
    }
}

extension ShopViewController {
    // MARK: - UICollectionView DataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredManufacturers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuplierContainerCell.identifier, for: indexPath) as? SuplierContainerCell else {
            return UICollectionViewCell()
        }
        let manufacturer = filteredManufacturers[indexPath.item]
        
        let filteredProducts = filteredProductsBySupplier(for: manufacturer)
        
        cell.configure(with: manufacturer, products: filteredProducts)
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedManufacturer = filteredManufacturers[indexPath.item]
        let filteredProducts = filteredProductsBySupplier(for: selectedManufacturer)
        
        guard let firstProduct = filteredProducts.first else { return }
        
        navigationHandler.navigateToProductDetails(from: self, with: firstProduct)
    }
    
    // MARK: - Helper Methods

    private func filteredProductsBySupplier(for manufacturer: Suplier) -> [Product] {
        return homePageViewModel.filteredBySupplier(for: manufacturer.name, from: homePageViewModel.products)
    }
}


