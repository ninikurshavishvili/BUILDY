//
//  CategoriesViewModel.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 10.01.25.
//

import Foundation
import FirebaseStorage

class CategoriesViewModel {
    private let storage = Storage.storage()
    private(set) var categories: [Category] = []
    var onCategoriesFetched: (() -> Void)?
    
    func fetchCategories() {
        let storageRef = storage.reference().child("CategoriesImages")
        
        DispatchQueue.global(qos: .userInitiated).async {
            storageRef.listAll { [weak self] result, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error listing category images: \(error.localizedDescription)")
                    return
                }
                
                guard let result = result else {
                    print("Failed to fetch result from Firebase Storage.")
                    return
                }
                
                var fetchedCategories: [Category] = []
                let dispatchGroup = DispatchGroup()
                
                for item in result.items {
                    dispatchGroup.enter()
                    
                    let fileName = item.name
                    let categoryName = fileName.replacingOccurrences(of: ".png", with: "")
                    
                    item.downloadURL { url, error in
                        if let url = url {
                            let category = Category(name: categoryName, imageURL: url.absoluteString)
                            fetchedCategories.append(category)
                        } else {
                            print("Failed to fetch URL for \(fileName): \(error?.localizedDescription ?? "Unknown error")")
                        }
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: DispatchQueue.global(qos: .userInitiated)) {
                    fetchedCategories.sort { $0.name < $1.name }
                    
                    DispatchQueue.main.async {
                        self.categories = fetchedCategories
                        self.onCategoriesFetched?()
                    }
                }
            }
        }
    }
    
    func prefetchCategories() {
        fetchCategories()
    }
}

