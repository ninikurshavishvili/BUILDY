//
//  ProductNavigationHandler.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 26.01.25.
//
import Foundation
import UIKit
import SwiftUI

protocol NavigationHandler {
    func handleNavigation(for collectionView: UICollectionView, indexPath: IndexPath, navigationController: UINavigationController?)
}

final class ProductNavigationHandler: NavigationHandler {
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
