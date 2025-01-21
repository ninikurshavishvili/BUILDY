//
//  Product.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 06.01.25.
//

import UIKit

struct Product: Hashable {
    let name: String
    let price: String
    let codeID: String
    let unit: String
    let featuresGeo: String
    let category: String 
    let link: String?
    var imageURL: UIImage?
    let supplier: String
    
    var linkToURL: URL? {
        return URL(string: link ?? "")
    }

    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.codeID == rhs.codeID
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(codeID)
    }
}
