//
//  ImageLoader.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 30.01.25.
//

import UIKit

final class ImageLoader {
    static func fetchImage(from urlString: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            completion(UIImage(systemName: "photo"))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let data = data, error == nil, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(UIImage(systemName: "photo"))
                }
            }
        }.resume()
    }
}
