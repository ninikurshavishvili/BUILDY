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

    private let categoriesContainerCell: CategoriesContainerCell = {
        let cell = CategoriesContainerCell()
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()

    private let productsContainerCell: ProductsContainerCell = {
        let cell = ProductsContainerCell()
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
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
        contentView.addSubview(categoriesContainerCell)
        contentView.addSubview(productsContainerCell)
        contentView.addSubview(productCarouselCell)

        categoriesContainerCell.configure(delegate: self, dataSource: self) { [weak self] in
            guard let self = self else { return }
            let categoriesVC = CategoriesViewController()
            self.navigationController?.pushViewController(categoriesVC, animated: true)
        }
        productsContainerCell.configure(delegate: self, dataSource: self)

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

            categoriesContainerCell.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            categoriesContainerCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoriesContainerCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoriesContainerCell.heightAnchor.constraint(equalToConstant: 160),

            productsContainerCell.topAnchor.constraint(equalTo: categoriesContainerCell.bottomAnchor, constant: 16),
            productsContainerCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productsContainerCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productsContainerCell.heightAnchor.constraint(equalToConstant: 250),

            productCarouselCell.topAnchor.constraint(equalTo: productsContainerCell.bottomAnchor, constant: 16),
            productCarouselCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productCarouselCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productCarouselCell.heightAnchor.constraint(equalToConstant: 300),

            productCarouselCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    private func fetchData() {
        categoriesViewModel.fetchCategories()
        categoriesViewModel.onCategoriesFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.categoriesContainerCell.categoriesCollectionView.reloadData()
            }
        }

        viewModel.fetchProducts()
        viewModel.onProductsFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.productsContainerCell.productsCollectionView.reloadData()
                self?.productCarouselCell.configure(with: self?.viewModel.products ?? [])
            }
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension HomePageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesContainerCell.categoriesCollectionView {
            return categoriesViewModel.categories.count
        } else if collectionView == productsContainerCell.productsCollectionView {
            return viewModel.products.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesContainerCell.categoriesCollectionView {
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
        if collectionView == categoriesContainerCell.categoriesCollectionView {
            return CGSize(width: 100, height: 120)
        } else if collectionView == productsContainerCell.productsCollectionView {
            return CGSize(width: 200, height: 250)
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesContainerCell.categoriesCollectionView {
            let selectedCategory = categoriesViewModel.categories[indexPath.item]
            let filteredProducts = viewModel.products(for: selectedCategory.name)
            let categoryDetailVC = CategoryDetailViewController()
            categoryDetailVC.configure(with: filteredProducts)
            navigationController?.pushViewController(categoryDetailVC, animated: true)
        }
    }
}

