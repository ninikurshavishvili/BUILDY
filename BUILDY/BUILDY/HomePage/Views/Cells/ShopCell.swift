//
//  ShopCell.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 22.01.25.
//

import UIKit

class ShopCell: UICollectionViewCell {
    
    static let identifier = "ShopCell"

    private let shopImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private let shopNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(shopImageView)
        contentView.addSubview(shopNameLabel)

        NSLayoutConstraint.activate([
            shopImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shopImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shopImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shopImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),

            shopNameLabel.topAnchor.constraint(equalTo: shopImageView.bottomAnchor, constant: 4),
            shopNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            shopNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            shopNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }

    func configure(with supplier: Suplier) {
        shopNameLabel.text = supplier.name
        loadImage(from: supplier.imageURL)
    }

    private func loadImage(from urlString: String?) {
        guard let logoURL = urlString, let url = URL(string: logoURL) else {
            shopImageView.image = UIImage(named: "placeholder_image") 
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self?.shopImageView.image = UIImage(named: "placeholder_image")
                }
                return
            }
            DispatchQueue.main.async {
                self.shopImageView.image = image
            }
        }.resume()
    }
}
