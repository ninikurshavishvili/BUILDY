//
//  ImageFetcherProtocol.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 05.01.25.
//

import UIKit

protocol ImageFetcherProtocol {
    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

class ImageFetcher: ImageFetcherProtocol {
    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error fetching image: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }.resume()
    }
}
