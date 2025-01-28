//
//  AppColors.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 25.01.25.
//


import UIKit
import SwiftUI

struct AppColors {
    static let titleColor = UIColor(red: 52/255, green: 58/255, blue: 69/255, alpha: 1) 
    static let customOrange = UIColor(red: 255/255, green: 108/255, blue: 46/255, alpha: 1)
}


extension Color {
    static let titleColor = Color(AppColors.titleColor)
    static let customOrange = Color(AppColors.customOrange)
}
