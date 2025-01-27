//
//  ShopViewModel.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 11.01.25.
//

import Foundation
import FirebaseStorage

class ShopViewModel {
    private let storage = Storage.storage()
    private(set) var suppliers: [Suplier] = [] 
    var onSuppliersFetched: (() -> Void)?

    func fetchSuppliers() {
        let storageRef = storage.reference().child("SuplierLogos")
        
        DispatchQueue.global(qos: .userInitiated).async {
            storageRef.listAll { [weak self] result, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error listing supplier logos: \(error.localizedDescription)")
                    return
                }
                
                guard let result = result else {
                    print("Failed to fetch result from Firebase Storage.")
                    return
                }
                
                let dispatchGroup = DispatchGroup()
                for item in result.items {
                    dispatchGroup.enter()
                    
                    let fileName = item.name
                    let supplierName = fileName.replacingOccurrences(of: ".png", with: "")
                    
                    item.downloadURL { url, error in
                        if let url = url {
                            let supplier = Suplier(name: supplierName, imageURL: url.absoluteString)
                            self.suppliers.append(supplier)
                            print("🌸🌸 \(supplierName) downloaded")
                        } else {
                            print("Failed to fetch URL for \(fileName): \(error?.localizedDescription ?? "Unknown error")")
                        }
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    self.onSuppliersFetched?()
                }
            }
        }
    }

    func filterSuppliers(for query: String, completion: @escaping ([Suplier]) -> Void) {
        if query.isEmpty {
            completion(suppliers)
        } else {
            let filteredSuppliers = suppliers.filter {
                $0.name.lowercased().contains(query.lowercased())
            }
            completion(filteredSuppliers)
        }
    }
    
    func prefetchSuppliers() {
        fetchSuppliers()
    }
}

