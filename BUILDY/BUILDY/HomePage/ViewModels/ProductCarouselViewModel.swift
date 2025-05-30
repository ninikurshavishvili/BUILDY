//
//  ProductCarouselViewModel.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 25.01.25.
//


import Foundation

final class ProductCarouselViewModel {
    private(set) var products: [Product] = []

    func fetchProducts(from allProducts: [Product]) {
        self.products = Array(allProducts.shuffled().prefix(5))
    }
    
    func prefetchProducts(allProducts: [Product]) {
        fetchProducts(from: allProducts)
    }
}
