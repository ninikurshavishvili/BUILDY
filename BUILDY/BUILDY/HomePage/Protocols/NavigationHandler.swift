//
//  NavigationHandler.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 14.01.25.
//

import Foundation
import UIKit
import SwiftUI


protocol NavigationHandler {
    func handleNavigation(for collectionView: UICollectionView, indexPath: IndexPath, navigationController: UINavigationController?)
}

class ProductNavigationHandler: NavigationHandler {
    private let viewModel: HomePageViewModel

    init(viewModel: HomePageViewModel) {
        self.viewModel = viewModel
    }

    func handleNavigation(for collectionView: UICollectionView, indexPath: IndexPath, navigationController: UINavigationController?) {
        let selectedProduct = viewModel.products[indexPath.item]
        let productDetailsView = ProductDetailsView(product: selectedProduct)
            .environmentObject(WishlistManager.shared)
            .environmentObject(CartManager.shared)
        
        let hostingController = UIHostingController(rootView: productDetailsView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
}

class CategoryNavigationHandler: NavigationHandler {
    private let categoriesViewModel: CategoriesViewModel
    private let viewModel: HomePageViewModel

    init(categoriesViewModel: CategoriesViewModel, viewModel: HomePageViewModel) {
        self.categoriesViewModel = categoriesViewModel
        self.viewModel = viewModel
    }

    func handleNavigation(for collectionView: UICollectionView, indexPath: IndexPath, navigationController: UINavigationController?) {
        let selectedCategory = categoriesViewModel.categories[indexPath.item]
        let filteredProducts = viewModel.products(for: selectedCategory.name)
        let categoryDetailVC = CategoryDetailViewController(navigationHandler: CategoryDetailNavigationHandler())
        categoryDetailVC.configure(with: filteredProducts)
        navigationController?.pushViewController(categoryDetailVC, animated: true)
    }
}
