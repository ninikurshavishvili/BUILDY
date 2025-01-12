//
//  ProductShopCell.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 12.01.25.
//

import UIKit

class ProductShopCell: UICollectionViewCell {
    static let identifier = "ProductShopCell"
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.backgroundColor = .white
        
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(heartButton)

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.65),
            
            heartButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            heartButton.widthAnchor.constraint(equalToConstant: 24),
            heartButton.heightAnchor.constraint(equalToConstant: 24),
            
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 5),
            productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            priceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: Product) {
        productImageView.image = product.imageURL
        productNameLabel.text = product.name
        priceLabel.text = "\(product.price)₾"
    }
}

