//
//  AddViewCell.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 22.01.25.
//

import UIKit
import FirebaseStorage

class AddViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "AddViewCell"

    private let adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        fetchAdImage()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        fetchAdImage()
    }

    private func setupUI() {
        contentView.addSubview(adImageView)
        
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            adImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            adImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            adImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            adImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func fetchAdImage() {
        let storageRef = Storage.storage().reference().child("Adds/solo.png")

        storageRef.downloadURL { [weak self] url, error in
            guard let url = url, error == nil else {
                print("Error fetching ad image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.adImageView.image = image
                    }
                } else {
                    print("Error loading ad image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        }
    }
}

