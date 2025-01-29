//
//  ProductsDataSource.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 14.01.25.
//

import UIKit

final class ProductsDataSource: NSObject, UICollectionViewDataSource {
    private let viewModel: HomePageViewModel
    
    init(viewModel: HomePageViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as! ProductCell
        let product = viewModel.products[indexPath.item]
        
        cell.nameLabel.text = product.name
        cell.priceLabel.text = "\(product.price)"
        
        if let imageURL = product.imageURL {
            cell.productImageView.image = imageURL
        } else {
            cell.productImageView.image = UIImage(named: "placeholder")
        }
        return cell
    }

}
