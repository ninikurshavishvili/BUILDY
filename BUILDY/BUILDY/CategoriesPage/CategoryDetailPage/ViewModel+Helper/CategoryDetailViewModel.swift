//
//  CategoryDetailViewModel.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 15.01.25.
//


import Foundation

class CategoryDetailViewModel {
    private(set) var products: [Product] = []
    
    func configure(with products: [Product]) {
        self.products = products
    }
    
    func getProduct(at index: Int) -> Product? {
        guard index >= 0 && index < products.count else { return nil }
        return products[index]
    }
    
    var productCount: Int {
        return products.count
    }
}
