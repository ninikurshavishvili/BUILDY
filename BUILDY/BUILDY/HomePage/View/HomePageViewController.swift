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

    private let collectionView: UICollectionView = {
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

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "მოძებნე"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private var viewModel = HomePageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchProducts()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(searchBar)
        contentView.addSubview(collectionView)
        contentView.addSubview(productCarouselCell)

        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")

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

            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 250),

            productCarouselCell.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            productCarouselCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productCarouselCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productCarouselCell.heightAnchor.constraint(equalToConstant: 300),

            productCarouselCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    private func fetchProducts() {
        viewModel.fetchProducts()
        viewModel.onProductsFetched = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.collectionView.reloadData()
                self.productCarouselCell.configure(with: self.viewModel.products)
            }
        }
    }

}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension HomePageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = viewModel.products[indexPath.item]

        cell.nameLabel.text = product.name
        cell.priceLabel.text = product.price
        cell.supplierLabel.text = "Supplier: \(product.supplier)"
        if let imageURL = product.imageURL {
            cell.productImageView.image = imageURL
        } else {
            cell.productImageView.image = UIImage(named: "placeholder")
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 250)
    }
}
