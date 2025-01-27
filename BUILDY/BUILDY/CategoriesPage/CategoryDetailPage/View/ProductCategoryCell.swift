//
//  ProductCategoryCell.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 10.01.25.
//

import UIKit

final class ProductCategoryCell: UICollectionViewCell {
    
    static let identifier = "ProductCategoryCell"
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let infoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var product: Product?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(productImageView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(infoContainerView)
        infoContainerView.addSubview(productNameLabel)
        infoContainerView.addSubview(productPriceLabel)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            productImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24),
            
            infoContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            infoContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            infoContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            infoContainerView.heightAnchor.constraint(equalToConstant: 60),
            
            productNameLabel.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 8),
            productNameLabel.topAnchor.constraint(equalTo: infoContainerView.topAnchor, constant: 8),
            productNameLabel.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -8),
            
            productPriceLabel.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 8),
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 4),
            productPriceLabel.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -8),
        ])
        
        favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: Product) {
        self.product = product
        productNameLabel.text = product.name
        productPriceLabel.text = "\(product.price)"
        productImageView.image = product.imageURL
        
        favoriteButton.isSelected = WishlistManager.shared.isInWishlist(product: product)
    }
    
    @objc private func didTapFavorite() {
        guard let product = product else { return }
        
        if WishlistManager.shared.isInWishlist(product: product) {
            WishlistManager.shared.removeFromWishlist(product: product)
            favoriteButton.isSelected = false
        } else {
            WishlistManager.shared.addToWishlist(product: product)
            favoriteButton.isSelected = true
        }
    }
}

