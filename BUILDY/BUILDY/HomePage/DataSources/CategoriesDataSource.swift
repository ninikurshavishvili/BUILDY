//
//  CategoriesDataSource.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 14.01.25.
//

import UIKit

class CategoriesDataSource: NSObject, UICollectionViewDataSource {
    private let viewModel: CategoriesViewModel
    
    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.identifier, for: indexPath) as! CategoriesCell
        let category = viewModel.categories[indexPath.item]
        cell.configure(with: category)
        return cell
    }
}
