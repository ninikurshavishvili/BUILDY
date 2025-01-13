//
//  SuplierCellView.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 13.01.25.
//


import UIKit

class SuplierCellView: UIView {
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(logoImageView)
        addSubview(nameLabel)

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            logoImageView.heightAnchor.constraint(equalToConstant: 50),

            nameLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }

    func configure(with supplier: Suplier) {
        if let logoURL = supplier.imageURL, let url = URL(string: logoURL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let self = self, let data = data, error == nil, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.logoImageView.image = image
                }
            }.resume()
        } else {
            logoImageView.image = UIImage(systemName: "photo")
        }
        nameLabel.text = supplier.name
    }
}
extension UIView {
    func viewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            responder = responder?.next
        }
        return nil
    }
}
