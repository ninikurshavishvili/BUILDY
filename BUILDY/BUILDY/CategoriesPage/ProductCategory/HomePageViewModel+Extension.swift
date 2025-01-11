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
        
                print("Filtered \(filteredProducts.count) products for category \(category)")
                        print("Filtered \(filteredProducts.count) products for category \(category)")
                        print("🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑")
                        print("Filtering products for category: \(category)")
                        print("🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑")
                        print("Total products: \(products.count)")
                        print("Filtered products count: \(filteredProducts.count)")
                        print("🛑🛑🛑🛑🛑🛑🛑")
                        for product in filteredProducts {
                            print("Filtered Product - Name: \(product.name), Category: \(product.featuresGeo)")
                        }

        return filteredProducts
    }
    
    func products(for supplier: String, from allProducts: [Product]) -> [Product] {
        let normalizedSupplier = supplier.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let filteredProducts = allProducts.filter {
            $0.supplier.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == normalizedSupplier
        }
        print("✅✅✅✅")
        
        print("Filtered \(filteredProducts.count) products for supplier \(supplier)")
        return filteredProducts
    }

    
}


