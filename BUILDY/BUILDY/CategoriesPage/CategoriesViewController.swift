//
//  CategoriesViewController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 10.01.25.
//


import UIKit

class CategoriesViewController: UIViewController {
    
    private var viewModel = CategoriesViewModel()
    private var categories: [Category] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: 140)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        view.backgroundColor = .systemGroupedBackground
        setupCollectionView()
        setupViewModel()
        fetchCategories()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identifier)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupViewModel() {
        viewModel.onCategoriesFetched = { [weak self] in
            guard let self = self else { return }
            self.categories = self.viewModel.categories
            self.collectionView.reloadData()
        }
    }
    
    private func fetchCategories() {
        viewModel.fetchCategories()
    }
}

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.identifier, for: indexPath) as? CategoriesCell else {
            return UICollectionViewCell()
        }
        
        let category = categories[indexPath.item]
        cell.configure(with: category)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.item]
        print("Selected category: \(category.name)")

        // Fetch filtered products using the category name
        let filteredProducts = HomePageViewModel().products(for: category.name)
        print("Filtered products count: \(filteredProducts.count)")

        // Instantiate ProductCategoryViewController and pass filtered products
        let productCategoryVC = ProductCategoryViewController()
        productCategoryVC.configure(with: filteredProducts)
        navigationController?.pushViewController(productCategoryVC, animated: true)
    }


}
