//
//  CategoriesContainerCell.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 13.01.25.
//

import UIKit
import Lottie

class CategoriesContainerCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CategoriesContainerCell"

    private let categoriesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = AppColors.titleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let seeAllCategories: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.setTitleColor(AppColors.customOrange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let loadingAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "loading-animation") 
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()


    var onSeeAllTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        seeAllCategories.addTarget(self, action: #selector(seeAllTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(categoriesTitleLabel)
        contentView.addSubview(seeAllCategories)
        contentView.addSubview(categoriesCollectionView)

        NSLayoutConstraint.activate([
            categoriesTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoriesTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            seeAllCategories.centerYAnchor.constraint(equalTo: categoriesTitleLabel.centerYAnchor),
            seeAllCategories.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            categoriesCollectionView.topAnchor.constraint(equalTo: categoriesTitleLabel.bottomAnchor, constant: 16),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource, onSeeAllTapped: @escaping () -> Void) {
        self.onSeeAllTapped = onSeeAllTapped
        categoriesCollectionView.delegate = delegate
        categoriesCollectionView.dataSource = dataSource
        categoriesCollectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identifier)
    }

    @objc private func seeAllTapped() {
        onSeeAllTapped?()
    }
}

