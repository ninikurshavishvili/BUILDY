//
//  HomePageViewController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 05.01.25.
//

import UIKit

class HomePageViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "მოძებნე"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let categoriesHeaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let categoriesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(seeAllTapped), for: .touchUpInside)
        return button
    }()
    
    private let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    private let productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let productCarouselCell: ProductCarouselCell = {
        let cell = ProductCarouselCell()
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()

    private var categoriesViewModel = CategoriesViewModel()
    private var viewModel = HomePageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(searchBar)
        contentView.addSubview(categoriesHeaderView)
        categoriesHeaderView.addSubview(categoriesTitleLabel)
        categoriesHeaderView.addSubview(seeAllButton)
        contentView.addSubview(categoriesCollectionView)
        contentView.addSubview(productCollectionView)
        contentView.addSubview(productCarouselCell)

        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.backgroundColor = .white
        categoriesCollectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identifier)

        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.backgroundColor = .white
        productCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")

        setupConstraints()
    }

    private func setupConstraints() {
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

            categoriesHeaderView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            categoriesHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoriesHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            categoriesHeaderView.heightAnchor.constraint(equalToConstant: 30),

            categoriesTitleLabel.leadingAnchor.constraint(equalTo: categoriesHeaderView.leadingAnchor),
            categoriesTitleLabel.centerYAnchor.constraint(equalTo: categoriesHeaderView.centerYAnchor),

            seeAllButton.trailingAnchor.constraint(equalTo: categoriesHeaderView.trailingAnchor),
            seeAllButton.centerYAnchor.constraint(equalTo: categoriesHeaderView.centerYAnchor),

            categoriesCollectionView.topAnchor.constraint(equalTo: categoriesHeaderView.bottomAnchor, constant: 8),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 120),

            productCollectionView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: 16),
            productCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productCollectionView.heightAnchor.constraint(equalToConstant: 250),

            productCarouselCell.topAnchor.constraint(equalTo: productCollectionView.bottomAnchor, constant: 16),
            productCarouselCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productCarouselCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productCarouselCell.heightAnchor.constraint(equalToConstant: 300),

            productCarouselCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    
    @objc private func seeAllTapped() {
        let categoriesVC = CategoriesViewController()
        navigationController?.pushViewController(categoriesVC, animated: true)
    }

    private func fetchData() {
        categoriesViewModel.fetchCategories()
        categoriesViewModel.onCategoriesFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.categoriesCollectionView.reloadData()
            }
        }

        viewModel.fetchProducts()
        viewModel.onProductsFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.productCollectionView.reloadData()
                self?.productCarouselCell.configure(with: self?.viewModel.products ?? [])
            }
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension HomePageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView {
            return categoriesViewModel.categories.count
        } else if collectionView == productCollectionView {
            return viewModel.products.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.identifier, for: indexPath) as! CategoriesCell
            let category = categoriesViewModel.categories[indexPath.item]
            cell.configure(with: category)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as! ProductCell
            let product = viewModel.products[indexPath.item]
            cell.nameLabel.text = product.name
            cell.priceLabel.text = "\(product.price)"
            cell.supplierLabel.text = "Supplier: \(product.supplier)"
            if let imageURL = product.imageURL {
                cell.productImageView.image = imageURL
            } else {
                cell.productImageView.image = UIImage(named: "placeholder")
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoriesCollectionView {
            return CGSize(width: 100, height: 120)
        } else if collectionView == productCollectionView {
            return CGSize(width: 200, height: 250)
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollectionView {
            let selectedCategory = categoriesViewModel.categories[indexPath.item]
            print("Selected category from HOMEPGE 🚀🚀: \(selectedCategory.name)")

            let filteredProducts = viewModel.products(for: selectedCategory.name)
            print("Filtered products count: \(filteredProducts.count)")

            let categoryDetailVC = CategoryDetailViewController()
            categoryDetailVC.configure(with: filteredProducts)
            navigationController?.pushViewController(categoryDetailVC, animated: true)
        }
    }
    

}

