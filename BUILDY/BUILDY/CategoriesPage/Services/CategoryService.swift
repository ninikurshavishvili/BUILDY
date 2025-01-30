//
//  CategoryService.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 30.01.25.
//

import Foundation
import FirebaseStorage

final class CategoryService {
    private let storage = Storage.storage()
    
    func fetchCategories(completion: @escaping ([Category]) -> Void) {
        let storageRef = storage.reference().child("CategoriesImages")

        DispatchQueue.global(qos: .userInitiated).async {
            storageRef.listAll { result, error in
                if let error = error {
                    print("Error listing category images: \(error.localizedDescription)")
                    completion([])
                    return
                }

                guard let result = result else {
                    print("Failed to fetch result from Firebase Storage.")
                    completion([])
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

                dispatchGroup.notify(queue: DispatchQueue.main) {
                    completion(fetchedCategories.sorted { $0.name < $1.name })
                }
            }
        }
    }
}
