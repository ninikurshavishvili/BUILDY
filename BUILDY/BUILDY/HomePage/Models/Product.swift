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
}
