//
//  ProductCache.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 10.01.25.
//


import Foundation

class ProductCache {
    static let shared = ProductCache()
    private init() {}

    private var cachedProducts: [Product] = []

    func storeProducts(_ products: [Product]) {
        cachedProducts = products
    }

    func getProducts() -> [Product] {
        return cachedProducts
    }

    func clearProducts() {
        cachedProducts.removeAll()
    }

    var isCacheEmpty: Bool {
        return cachedProducts.isEmpty
    }
}
