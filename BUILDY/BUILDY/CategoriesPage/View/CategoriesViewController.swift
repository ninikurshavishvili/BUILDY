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

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
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
    
    private let browseLabel: UILabel = {
        let label = UILabel()
        label.text = "Browse by Category"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: 140)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupCollectionView()
        setupViewModel()
        fetchCategories()
        
        searchBar.delegate = self
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(searchBar)
        contentView.addSubview(browseLabel)
        contentView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            searchBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 50),

            browseLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            browseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            collectionView.topAnchor.constraint(equalTo: browseLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identifier)
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

        let filteredProducts = HomePageViewModel().products(for: category.name)
        print("Filtered products count: \(filteredProducts.count)")

        let productCategoryVC = CategoryDetailViewController(navigationHandler: CategoryDetailNavigationHandler())
        productCategoryVC.configure(with: filteredProducts)
        navigationController?.pushViewController(productCategoryVC, animated: true)
    }
}

extension CategoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            categories = viewModel.categories
        } else {
            categories = viewModel.categories.filter { category in
                category.name.lowercased().contains(searchText.lowercased())
            }
        }
        collectionView.reloadData()
    }
}
