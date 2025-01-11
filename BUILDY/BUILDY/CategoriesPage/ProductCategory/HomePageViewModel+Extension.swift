//
//  HomePageViewModel+Extension.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 10.01.25.
//
import Foundation

extension HomePageViewModel {
    /// Filters products for a specific category.
//    func products(for category: String) -> [Product] {
//        let filteredProducts = products.filter { $0.category == category }
//        
//        // Debugging prints
//        print("Filtered \(filteredProducts.count) products for category \(category)")
//        print("🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑")
//        print("Filtering products for category: \(category)")
//        print("🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑")
//        print("Total products: \(products.count)")
//        print("Filtered products count: \(filteredProducts.count)")
//        print("🛑🛑🛑🛑🛑🛑🛑")
//        for product in filteredProducts {
//            print("Filtered Product - Name: \(product.name), Category: \(product.featuresGeo)")
//        }
//        
//        return filteredProducts
//    }
    
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

}
