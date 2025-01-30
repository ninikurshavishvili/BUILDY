//
//  HomePageViewModel.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 05.01.25.
//
import Foundation
import FirebaseDatabase
import UIKit

final class HomePageViewModel {
    
    var products: [Product] {
        return ProductCache.shared.getProducts()
    }
    var onProductsFetched: (() -> Void)?

    private let firebaseService: FirebaseServiceProtocol
    private let imageFetcher: ImageFetcherProtocol
    private let suppliers: [String] = ["kerama-marazzi", "Nova"]
    
    init(firebaseService: FirebaseServiceProtocol = FirebaseService(), imageFetcher: ImageFetcherProtocol = ImageFetcher()) {
        self.firebaseService = firebaseService
        self.imageFetcher = imageFetcher
    }

    func fetchProducts() {
        if !ProductCache.shared.isCacheEmpty {
            print("Using cached products.")
            DispatchQueue.main.async {
                self.onProductsFetched?()
            }
            return
        }

        print("Fetching products from Firebase.")
        var allProducts: [Product] = []
        let fetchGroup = DispatchGroup()

        for supplier in suppliers {
            fetchGroup.enter()
            DispatchQueue.global(qos: .userInitiated).async {
                self.firebaseService.fetchData(from: "1iiGe9MNfRWe7I5ZC78qQtdLydxHxK4Umlx3vce8yxYU/\(supplier)") { result in
                    switch result {
                    case .success(let productsData):
                        print("Fetched \(productsData.count) products for supplier \(supplier)")
                        let supplierProducts = productsData.compactMap { _, productData -> Product? in
                            guard let productInfo = productData as? [String: Any] else { return nil }
                            
                            let supplierName = productInfo["მომწოდებელი"] as? String
                            let name = productInfo["დასახელება"] as? String
                            let price = productInfo["გასაყიდი ფასი"] as? String
                            let unit = productInfo["ერთეული"] as? String
                            let featuresGeo = productInfo["მახასიათებლები GEO"] as? String
                            let category = productInfo["კატეგორია"] as? String
                            let link = productInfo["Links"] as? String
                            let codeID = productInfo["საძიებო კოდი"] as? String

                            return Product(
                                name: name ?? "Unknown",
                                price: price ?? "0",
                                codeID: codeID ?? "Unknown",
                                unit: unit ?? "",
                                featuresGeo: featuresGeo ?? "",
                                category: category ?? "Unknown",
                                link: link ?? "",
                                imageURL: nil,
                                supplier: supplierName ?? "Unknown"
                            )
                        }
                        DispatchQueue.global(qos: .utility).async(flags: .barrier) {
                            allProducts.append(contentsOf: supplierProducts)
                        }
                    case .failure(let error):
                        print("Failed to fetch products for supplier \(supplier): \(error.localizedDescription)")
                    }
                    fetchGroup.leave()
                }
            }
        }

        fetchGroup.notify(queue: .main) {
            ProductCache.shared.storeProducts(allProducts)
            self.fetchImagesForProducts {
                DispatchQueue.main.async {
                    self.onProductsFetched?()
                }
            }
        }
    }

    private func fetchImagesForProducts(completion: @escaping () -> Void) {
        let imageFetchGroup = DispatchGroup()
        var updatedProducts = products

        for index in 0..<updatedProducts.count {
            let product = updatedProducts[index]
            guard let urlString = product.link, let url = URL(string: urlString) else { continue }

            imageFetchGroup.enter()
            DispatchQueue.global(qos: .background).async {
                self.imageFetcher.fetchImage(from: url) { image in
                    if let image = image {
                        updatedProducts[index].imageURL = image 
                    } else {
                        print("Image for product | \(product.name) | failed to load.")
                    }
                    imageFetchGroup.leave()
                }
            }
        }
        
        imageFetchGroup.notify(queue: .main) {
            ProductCache.shared.storeProducts(updatedProducts)
            completion()
        }
    }
    
}




