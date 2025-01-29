//
//  DataFetcher.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 14.01.25.
//


protocol DataFetcher {
    func fetchCategories(completion: @escaping () -> Void)
    func fetchProducts(completion: @escaping () -> Void)
    func fetchSuppliers(completion: @escaping () -> Void)
}

final class HomePageDataFetcher: DataFetcher {
    private let categoriesViewModel: CategoriesViewModel
    private let viewModel: HomePageViewModel
    private let shopViewModel: ShopViewModel

    init(categoriesViewModel: CategoriesViewModel, viewModel: HomePageViewModel, shopViewModel: ShopViewModel) {
        self.categoriesViewModel = categoriesViewModel
        self.viewModel = viewModel
        self.shopViewModel = shopViewModel
    }

    func fetchCategories(completion: @escaping () -> Void) {
        categoriesViewModel.fetchCategories()
        categoriesViewModel.onCategoriesFetched = {
            completion()
        }
    }

    func fetchProducts(completion: @escaping () -> Void) {
        viewModel.fetchProducts()
        viewModel.onProductsFetched = {
            completion()
        }
    }

    func fetchSuppliers(completion: @escaping () -> Void) {
        shopViewModel.fetchSuppliers()
        shopViewModel.onSuppliersFetched = {
            completion()
        }
    }
}

