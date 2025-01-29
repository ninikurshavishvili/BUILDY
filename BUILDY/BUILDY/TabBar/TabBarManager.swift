//
//  TabBarManager.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 29.01.25.
//

import UIKit
import SwiftUI

class TabBarManager {
    
    private var isGuestUser: Bool {
        UserDefaults.standard.bool(forKey: "isGuest")
    }

    func setupTabBar() -> [UIViewController] {
        let homePageVC = CustomNavigationController(rootViewController: HomePageViewController())
        homePageVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        let categoriesPageVC = CustomNavigationController(rootViewController: CategoriesViewController())
        categoriesPageVC.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "magnifyingglass"), tag: 1)

        let shopVC = CustomNavigationController(rootViewController: ShopViewController())
        shopVC.tabBarItem = UITabBarItem(title: "Shops", image: UIImage(systemName: "building.2"), tag: 2)

        let wishlistPageVC = CustomNavigationController(rootViewController: UIHostingController(
            rootView: WishlistPage()
                .environmentObject(WishlistManager.shared)
                .environmentObject(CartManager.shared)
        ))
        wishlistPageVC.tabBarItem = UITabBarItem(title: "Wishlist", image: UIImage(systemName: "heart"), tag: 3)

        let cartPageVC = CustomNavigationController(rootViewController: UIHostingController(
            rootView: CartPage()
                .environmentObject(WishlistManager.shared)
                .environmentObject(CartManager.shared)
        ))
        cartPageVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "bag"), tag: 4)

        return [homePageVC, categoriesPageVC, shopVC, wishlistPageVC, cartPageVC]
    }

    func shouldAllowTabSelection(at index: Int) -> Bool {
        if (index == 3 || index == 4) && isGuestUser {
            AuthenticationManager.shared.navigateToAuthorization()
            return false
        }
        return true
    }
}
