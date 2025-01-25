//
//  HomePageViewModel+Extension.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 10.01.25.
//
import Foundation

extension HomePageViewModel {
    func products(for category: String) -> [Product] {
        let normalizedCategory = category.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let filteredProducts = products.filter { $0.category.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == normalizedCategory }

        return filteredProducts
    }
}

extension HomePageViewModel {
    func filteredBySupplier(for supplier: String, from allProducts: [Product]) -> [Product] {
        let normalizedSupplier = supplier.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let filteredProducts = allProducts.filter {
            $0.supplier.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == normalizedSupplier
        }
        return filteredProducts
    }
}
