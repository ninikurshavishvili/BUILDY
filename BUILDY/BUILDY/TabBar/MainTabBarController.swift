//
//  MainTabBarController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 05.01.25.
//

import UIKit
import SwiftUI

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homePageVC = HomePageViewController()
        homePageVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)

        let categoriesPageVC = CategoriesViewController()
        categoriesPageVC.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "text.page.badge.magnifyingglass"), tag: 1)

        let shopVC = ShopViewController()
        shopVC.tabBarItem = UITabBarItem(title: "Shops", image: UIImage(systemName: "building.2.fill"), tag: 2)

        let wishlistPageVC = UIHostingController(rootView: WishlistPage())
        wishlistPageVC.tabBarItem = UITabBarItem(title: "Wishlist", image: UIImage(systemName: "heart.fill"), tag: 3)

        let cartPageVC = UIHostingController(rootView: CartPage())
        cartPageVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart.fill"), tag: 4)

        let tabBarList = [homePageVC, categoriesPageVC, shopVC, wishlistPageVC, cartPageVC]
        viewControllers = tabBarList
    }
}

