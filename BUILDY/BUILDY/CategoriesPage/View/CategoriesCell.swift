//
//  CategoriesCell.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 10.01.25.
//


import UIKit
import Lottie

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
    
    private let loadingAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "loading-animation")
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
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
        contentView.addSubview(loadingAnimationView)

        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            categoryImageView.heightAnchor.constraint(equalToConstant: 60),
            categoryImageView.widthAnchor.constraint(equalToConstant: 60),
            
            categoryLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            categoryLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            loadingAnimationView.centerXAnchor.constraint(equalTo: categoryImageView.centerXAnchor),
            loadingAnimationView.centerYAnchor.constraint(equalTo: categoryImageView.centerYAnchor),
            loadingAnimationView.widthAnchor.constraint(equalTo: categoryImageView.widthAnchor),
            loadingAnimationView.heightAnchor.constraint(equalTo: categoryImageView.heightAnchor)
        ])
    }

    func configure(with category: Category, viewModel: CategoriesViewModel) {
        categoryLabel.text = category.name
        categoryImageView.image = nil
        
        loadingAnimationView.isHidden = false
        loadingAnimationView.play()
        
        viewModel.fetchImage(for: category) { [weak self] image in
            guard let self = self else { return }
            self.loadingAnimationView.stop()
            self.loadingAnimationView.isHidden = true
            self.categoryImageView.image = image
        }
    }
}

