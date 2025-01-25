//
//  CategoriesCell.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 10.01.25.
//


import UIKit

class CategoriesCell: UICollectionViewCell {
    
    static let identifier = "CategoriesCell"
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        setupShadow()
        setupViews()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupShadow() {
        contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowRadius = 8
        contentView.layer.masksToBounds = false
    }
    
    private func setupViews() {
        contentView.addSubview(categoryImageView)
        contentView.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            categoryImageView.heightAnchor.constraint(equalToConstant: 60),
            categoryImageView.widthAnchor.constraint(equalToConstant: 60),
            
            categoryLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            categoryLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with category: Category) {
        categoryLabel.text = category.name
        if let imageURL = category.imageURL, let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.categoryImageView.image = image
                }
            }.resume()
        } else {
            categoryImageView.image = UIImage(systemName: "photo")
        }
    }
}

