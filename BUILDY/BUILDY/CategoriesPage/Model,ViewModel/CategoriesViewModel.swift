//
//  CategoriesViewModel.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 10.01.25.
//

import Foundation
import UIKit

class CategoriesViewModel {
    private let categoryService = CategoryService()
    private(set) var categories: [Category] = []
    var onCategoriesFetched: (() -> Void)?
    
    func fetchCategories() {
        categoryService.fetchCategories { [weak self] fetchedCategories in
            self?.categories = fetchedCategories
            self?.onCategoriesFetched?()
        }
    }

    func fetchImage(for category: Category, completion: @escaping (UIImage?) -> Void) {
        ImageLoader.fetchImage(from: category.imageURL, completion: completion)
    }
}

