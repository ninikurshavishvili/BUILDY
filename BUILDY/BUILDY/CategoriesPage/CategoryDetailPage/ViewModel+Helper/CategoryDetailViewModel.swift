//
//  CategoryDetailViewModel.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 15.01.25.
//


import Foundation

class CategoryDetailViewModel {
    private var allProducts: [Product] = []
    private(set) var products: [Product] = []

    func configure(with products: [Product]) {
        self.allProducts = products
        self.products = products
    }

    func getProduct(at index: Int) -> Product? {
        guard index >= 0 && index < products.count else { return nil }
        return products[index]
    }

    var productCount: Int {
        return products.count
    }

    func searchProducts(with query: String) {
        if query.isEmpty {
            products = allProducts
        } else {
            products = allProducts.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
    }
}
