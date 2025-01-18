//
//  ProductCarouselCell.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 08.01.25.
//


import UIKit

class ProductCarouselCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var products: [Product] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with products: [Product]) {
        self.products = products.shuffled().prefix(5).map { $0 }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath)
        
        let product = products[indexPath.item]
        configureCell(cell: cell, with: product)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // MARK: - Visual Customization of Cells
    private func configureCell(cell: UICollectionViewCell, with product: Product) {
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let productImageView = UIImageView()
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.image = product.imageURL
        cell.contentView.addSubview(productImageView)
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurContainer = UIVisualEffectView(effect: blurEffect)
        blurContainer.layer.cornerRadius = 18
        blurContainer.clipsToBounds = true
        blurContainer.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(blurContainer)
        
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textColor = .black
        nameLabel.text = product.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        blurContainer.contentView.addSubview(nameLabel)
        
        let supplierLabel = UILabel()
        supplierLabel.font = UIFont.systemFont(ofSize: 14)
        supplierLabel.textColor = .darkGray
        supplierLabel.text = product.supplier
        supplierLabel.translatesAutoresizingMaskIntoConstraints = false
        blurContainer.contentView.addSubview(supplierLabel)
        
        let priceLabel = UILabel()
        priceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        priceLabel.textColor = .white
        priceLabel.textAlignment = .center
        priceLabel.backgroundColor = .orange
        priceLabel.text = "\(product.price) ₾"
        priceLabel.layer.cornerRadius = 18
        priceLabel.clipsToBounds = true
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([

            productImageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            
            blurContainer.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10),
            blurContainer.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10),
            blurContainer.heightAnchor.constraint(equalToConstant: 70),
            blurContainer.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -10),
            
            priceLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -10),
            priceLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10),
            priceLabel.widthAnchor.constraint(equalToConstant: 80),
            priceLabel.heightAnchor.constraint(equalToConstant: 70),
            
            nameLabel.topAnchor.constraint(equalTo: blurContainer.contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: blurContainer.contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: blurContainer.contentView.trailingAnchor, constant: -10),
            
            supplierLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            supplierLabel.leadingAnchor.constraint(equalTo: blurContainer.contentView.leadingAnchor, constant: 10),
            supplierLabel.trailingAnchor.constraint(equalTo: blurContainer.contentView.trailingAnchor, constant: -10),
        ])
    }
}

