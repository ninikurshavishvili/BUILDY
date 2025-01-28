//
//  HomePageViewController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 05.01.25.
//

import UIKit
import SwiftUI

class HomePageViewController: UIViewController {
    
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let searchBar = UISearchBar()
    private let categoriesContainerCell = CategoriesContainerCell()
    private let productsContainerCell = ProductsContainerCell()
    private let productCarouselCell = ProductCarouselCell()
    private let shopsContainerCell = ShopsContainerCell()
    private let addViewCell = AddViewCell()
    
    private let topBarView = UIStackView()
    private let logoImageView = UIImageView()
    private let profileButton = UIButton()
    
    
    private var categoriesViewModel = CategoriesViewModel()
    private var viewModel = HomePageViewModel()
    private var shopViewModel = ShopViewModel()
    
    private var productNavigationHandler: NavigationHandler?
    private var categoryNavigationHandler: NavigationHandler?
    private var categoriesDataSource: CategoriesDataSource?
    private var productsDataSource: ProductsDataSource?
    private var shopsDataSource: ShopsDataSource?
    private var dataFetcher: HomePageDataFetcher?

     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupDataSources()
        fetchData()
        
        productNavigationHandler = ProductNavigationHandler(viewModel: viewModel)
        categoryNavigationHandler = CategoryNavigationHandler(categoriesViewModel: categoriesViewModel, viewModel: viewModel)
    }
        
    private func configureUI() {
        view.backgroundColor = .white
        configureTopBarView()
        configureScrollView()
        configureContentView()
        configureSearchBar()
        configureCells()
        setupConstraints()
    }
    
    private func configureTopBarView() {
        topBarView.axis = .horizontal
        topBarView.alignment = .center
        topBarView.distribution = .fill
        topBarView.spacing = 0
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        
        logoImageView.image = UIImage(named: "BUILDY_LOGO")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        profileButton.setImage(UIImage(named: "person"), for: .normal)
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        
        topBarView.addArrangedSubview(logoImageView)
        topBarView.addArrangedSubview(UIView())
        topBarView.addArrangedSubview(profileButton)
        
        view.addSubview(topBarView)
    }

    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
    }
    
    private func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }
    
    private func configureSearchBar() {
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
        contentView.addSubview(searchBar)
    }
    
    private func configureCells() {
        categoriesContainerCell.translatesAutoresizingMaskIntoConstraints = false
        productsContainerCell.translatesAutoresizingMaskIntoConstraints = false
        productCarouselCell.translatesAutoresizingMaskIntoConstraints = false
        shopsContainerCell.translatesAutoresizingMaskIntoConstraints = false
        addViewCell.translatesAutoresizingMaskIntoConstraints = false
        
        let cornerRadius: CGFloat = 16
        categoriesContainerCell.layer.cornerRadius = cornerRadius
        productsContainerCell.layer.cornerRadius = cornerRadius
        productCarouselCell.layer.cornerRadius = cornerRadius
        shopsContainerCell.layer.cornerRadius = cornerRadius
        addViewCell.layer.cornerRadius = cornerRadius
        
        contentView.addSubview(categoriesContainerCell)
        contentView.addSubview(productsContainerCell)
        contentView.addSubview(productCarouselCell)
        contentView.addSubview(shopsContainerCell)
        contentView.addSubview(addViewCell)
    }
    
    
    private func setupConstraints() {
        setupTopBarViewConstraints()
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupSearchBarConstraints()
        setupCategoriesContainerConstraints()
        setupProductCarouselConstraints()
        setupShopsContainerConstraints()
        setupAddViewConstraints()
        setupProductsContainerConstraints()
    }

    private func setupTopBarViewConstraints() {
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            topBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            topBarView.heightAnchor.constraint(equalToConstant: 50),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 70),
            logoImageView.widthAnchor.constraint(equalToConstant: 190),
            
            profileButton.heightAnchor.constraint(equalToConstant: 30),
            profileButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setupScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topBarView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupContentViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func setupSearchBarConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    private func setupCategoriesContainerConstraints() {
        NSLayoutConstraint.activate([
            categoriesContainerCell.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 24),
            categoriesContainerCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoriesContainerCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoriesContainerCell.heightAnchor.constraint(equalToConstant: 160)
        ])
    }

    private func setupProductCarouselConstraints() {
        NSLayoutConstraint.activate([
            productCarouselCell.topAnchor.constraint(equalTo: categoriesContainerCell.bottomAnchor, constant: 24),
            productCarouselCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productCarouselCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productCarouselCell.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func setupShopsContainerConstraints() {
        NSLayoutConstraint.activate([
            shopsContainerCell.topAnchor.constraint(equalTo: productCarouselCell.bottomAnchor, constant: 24),
            shopsContainerCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shopsContainerCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shopsContainerCell.heightAnchor.constraint(equalToConstant: 160)
        ])
    }

    private func setupAddViewConstraints() {
        NSLayoutConstraint.activate([
            addViewCell.topAnchor.constraint(equalTo: shopsContainerCell.bottomAnchor, constant: 24),
            addViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            addViewCell.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func setupProductsContainerConstraints() {
        NSLayoutConstraint.activate([
            productsContainerCell.topAnchor.constraint(equalTo: addViewCell.bottomAnchor, constant: 24),
            productsContainerCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productsContainerCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productsContainerCell.heightAnchor.constraint(equalToConstant: 250),
            productsContainerCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])

    }
    
    private func setupDataSources() {

        categoriesDataSource = CategoriesDataSource(viewModel: categoriesViewModel)
        productsDataSource = ProductsDataSource(viewModel: viewModel)
        shopsDataSource = ShopsDataSource(viewModel: shopViewModel)

        guard let categoriesDataSource = categoriesDataSource,
              let productsDataSource = productsDataSource,
              let shopsDataSource = shopsDataSource else {
            return
        }

        categoriesContainerCell.configure(delegate: self, dataSource: categoriesDataSource) { [weak self] in
            guard let self = self else { return }
            let categoriesVC = CategoriesViewController()
            self.navigationController?.pushViewController(categoriesVC, animated: true)
        }

        productsContainerCell.configure(delegate: self, dataSource: productsDataSource)

        shopsContainerCell.configure(delegate: self, dataSource: shopsDataSource) { [weak self] in
            guard let self = self else { return }
            let shopViewController = ShopViewController()
            self.navigationController?.pushViewController(shopViewController, animated: true)
        }
    }

    @objc private func profileButtonTapped() {
        let viewModel = AuthorizationViewModel()

        if viewModel.isGuest {
            AuthenticationManager.shared.navigateToAuthorization()
            return
        }

        viewModel.fetchUserProfile { [weak self] (name, email, phone, address) in
            guard let self = self else { return }
            
            let profileManager = ProfileManager()
            profileManager.userName = name
            profileManager.userEmail = email
            profileManager.userPhone = phone
            profileManager.userAddress = address
            
            let profileView = ProfileView(
                profileManager: profileManager,
                signOutAction: {
                    viewModel.signOut()
                    self.dismiss(animated: true)
                }
            )

            let hostingController = UIHostingController(rootView: profileView)
            hostingController.modalPresentationStyle = .fullScreen
            self.present(hostingController, animated: true)
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension HomePageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productsContainerCell.productsCollectionView {
            guard let productNavigationHandler = productNavigationHandler else { return }
            productNavigationHandler.handleNavigation(for: collectionView, indexPath: indexPath, navigationController: navigationController)
        } else if collectionView == categoriesContainerCell.categoriesCollectionView {
            guard let categoryNavigationHandler = categoryNavigationHandler else { return }
            categoryNavigationHandler.handleNavigation(for: collectionView, indexPath: indexPath, navigationController: navigationController)
        } else if collectionView == shopsContainerCell.shopsCollectionView {
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
            guard let categoriesDataSource = categoriesDataSource else {
                fatalError("categoriesDataSource is nil")
            }
            return categoriesDataSource.collectionView(collectionView, cellForItemAt: indexPath)
        } else if collectionView == productsContainerCell.productsCollectionView {
            guard let productsDataSource = productsDataSource else {
                fatalError("productsDataSource is nil")
            }
            return productsDataSource.collectionView(collectionView, cellForItemAt: indexPath)
        } else {
            guard let shopsDataSource = shopsDataSource else {
                fatalError("shopsDataSource is nil")
            }
            return shopsDataSource.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoriesContainerCell.categoriesCollectionView {
            return CGSize(width: 200, height: 120)
        } else if collectionView == productsContainerCell.productsCollectionView {
            return CGSize(width: 150, height: 180)
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
