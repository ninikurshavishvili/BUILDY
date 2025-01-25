//
//  ProductCell.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 06.01.25.
//
//
//
import UIKit

class ProductCell: UICollectionViewCell {

    static let reuseIdentifier = "ProductCell"

    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let blurContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

     let nameLabel: UILabel = {
        let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.cornerRadius = 16
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.layer.masksToBounds = true

        contentView.addSubview(productImageView)
        contentView.addSubview(blurContainerView)
        blurContainerView.addSubview(nameLabel)
        blurContainerView.addSubview(priceLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            blurContainerView.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            blurContainerView.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            blurContainerView.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor),
            blurContainerView.heightAnchor.constraint(equalToConstant: 60),

            // Name label
            nameLabel.topAnchor.constraint(equalTo: blurContainerView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: blurContainerView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: blurContainerView.trailingAnchor, constant: -8),

            // Price label
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: blurContainerView.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: blurContainerView.trailingAnchor, constant: -8),
            priceLabel.bottomAnchor.constraint(equalTo: blurContainerView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



