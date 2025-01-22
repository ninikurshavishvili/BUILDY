//
//  HomePageViewController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 05.01.25.
//

import UIKit
import SwiftUI

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
    
    private let shopsContainerCell: ShopsContainerCell = {
        let cell = ShopsContainerCell()
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()

    private var categoriesViewModel = CategoriesViewModel()
    private var viewModel = HomePageViewModel()
    
    private let topBarView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BUILDY_LOGO")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let profileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "person"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc private func profileButtonTapped() {
        print("Profile button tapped")
    }

    //MARK: I should fix it to be optional values🥁🥁
    private var productNavigationHandler: NavigationHandler!
    private var categoryNavigationHandler: NavigationHandler!
    private var dataFetcher: DataFetcher!
    
    private var categoriesDataSource: CategoriesDataSource!
    private var productsDataSource: ProductsDataSource!
    
    private var shopViewModel = ShopViewModel()
    private var shopsDataSource: ShopsDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDataSources()
        fetchData()
        
        productNavigationHandler = ProductNavigationHandler(viewModel: viewModel)
        categoryNavigationHandler = CategoryNavigationHandler(categoriesViewModel: categoriesViewModel, viewModel: viewModel)
    }
    
    private func setupUI() {
    
        view.backgroundColor = .white
        
        view.addSubview(topBarView)
        topBarView.addArrangedSubview(logoImageView)
        topBarView.addArrangedSubview(profileButton)

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(searchBar)
        contentView.addSubview(categoriesContainerCell)
        contentView.addSubview(productsContainerCell)
        contentView.addSubview(productCarouselCell)
        contentView.addSubview(shopsContainerCell)

        setupConstraints()

    }
    
    private func setupDataSources() {
        categoriesDataSource = CategoriesDataSource(viewModel: categoriesViewModel)
        productsDataSource = ProductsDataSource(viewModel: viewModel)
        shopsDataSource = ShopsDataSource(viewModel: shopViewModel)

        categoriesContainerCell.configure(delegate: self, dataSource: categoriesDataSource) { [weak self] in
            guard let self = self else { return }
            let categoriesVC = CategoriesViewController()
            self.navigationController?.pushViewController(categoriesVC, animated: true)
        }

        productsContainerCell.configure(delegate: self, dataSource: productsDataSource)

        shopsContainerCell.configure(delegate: self, dataSource: self) { [weak self] in
            guard let self = self else { return }
            let shopViewController = ShopViewController()
            self.navigationController?.pushViewController(shopViewController, animated: true)
        }
    }
    

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            topBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            topBarView.heightAnchor.constraint(equalToConstant: 50),

            logoImageView.heightAnchor.constraint(equalToConstant: 40),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),

            profileButton.heightAnchor.constraint(equalToConstant: 40),
            profileButton.widthAnchor.constraint(equalToConstant: 40),

            scrollView.topAnchor.constraint(equalTo: topBarView.bottomAnchor),
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

            productCarouselCell.topAnchor.constraint(equalTo: categoriesContainerCell.bottomAnchor, constant: 16),
            productCarouselCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productCarouselCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productCarouselCell.heightAnchor.constraint(equalToConstant: 300),

            shopsContainerCell.topAnchor.constraint(equalTo: productCarouselCell.bottomAnchor, constant: 16),
            shopsContainerCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shopsContainerCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shopsContainerCell.heightAnchor.constraint(equalToConstant: 160),

            productsContainerCell.topAnchor.constraint(equalTo: shopsContainerCell.bottomAnchor, constant: 16),
            productsContainerCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productsContainerCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productsContainerCell.heightAnchor.constraint(equalToConstant: 250),

            productsContainerCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
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

        shopViewModel.fetchSuppliers()
        shopViewModel.onSuppliersFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.shopsContainerCell.shopsCollectionView.reloadData()
            }
        }
    }

}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension HomePageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productsContainerCell.productsCollectionView {
            productNavigationHandler.handleNavigation(for: collectionView, indexPath: indexPath, navigationController: navigationController)
        } else if collectionView == categoriesContainerCell.categoriesCollectionView {
            categoryNavigationHandler.handleNavigation(for: collectionView, indexPath: indexPath, navigationController: navigationController)
        } else if collectionView == shopsContainerCell.shopsCollectionView {
            let selectedSupplier = shopViewModel.suppliers[indexPath.item]
            let shopDetailsVC = ShopViewController()
            navigationController?.pushViewController(shopDetailsVC, animated: true)
        }
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesContainerCell.categoriesCollectionView {
            return categoriesViewModel.categories.count
        } else if collectionView == productsContainerCell.productsCollectionView {
            return viewModel.products.count
        } else if collectionView == shopsContainerCell.shopsCollectionView {
            return shopViewModel.suppliers.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesContainerCell.categoriesCollectionView {
            return categoriesDataSource.collectionView(collectionView, cellForItemAt: indexPath)
        } else if collectionView == productsContainerCell.productsCollectionView {
            return productsDataSource.collectionView(collectionView, cellForItemAt: indexPath)
        } else {
            return shopsDataSource.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoriesContainerCell.categoriesCollectionView {
            return CGSize(width: 100, height: 120)
        } else if collectionView == productsContainerCell.productsCollectionView {
            return CGSize(width: 200, height: 250)
        } else if collectionView == shopsContainerCell.shopsCollectionView {
            return CGSize(width: 100, height: 100)
        }
        return .zero
    }

}

import SwiftUI

struct HomePageViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HomePageViewController {
        return HomePageViewController()
    }

    func updateUIViewController(_ uiViewController: HomePageViewController, context: Context) {

    }
}
struct HomePageViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomePageViewControllerRepresentable()
            .previewLayout(.sizeThatFits)
            .edgesIgnoringSafeArea(.all)
    }
}
