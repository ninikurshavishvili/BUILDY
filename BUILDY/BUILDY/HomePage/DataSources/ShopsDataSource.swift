//
//  ShopsDataSource.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 22.01.25.
//

import UIKit

final class ShopsDataSource: NSObject, UICollectionViewDataSource {
    private let viewModel: ShopViewModel
    
    init(viewModel: ShopViewModel) {
        self.viewModel = viewModel
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.suppliers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCell.identifier, for: indexPath) as! ShopCell
        let supplier = viewModel.suppliers[indexPath.item]
        cell.configure(with: supplier)
        return cell
    }
}
