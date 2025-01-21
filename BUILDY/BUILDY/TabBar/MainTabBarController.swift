//
//  MainTabBarController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 05.01.25.
//
import UIKit
import SwiftUI

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    private var isGuestUser: Bool {
        UserDefaults.standard.bool(forKey: "isGuest")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        let homePageVC = HomePageViewController()
        homePageVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)

        let categoriesPageVC = CategoriesViewController()
        categoriesPageVC.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "text.page.badge.magnifyingglass"), tag: 1)

        let shopVC = ShopViewController()
        shopVC.tabBarItem = UITabBarItem(title: "Shops", image: UIImage(systemName: "building.2.fill"), tag: 2)

        let wishlistPageVC = UIHostingController(
            rootView: WishlistPage()
                .environmentObject(WishlistManager.shared)
                .environmentObject(CartManager.shared)
        )
        wishlistPageVC.tabBarItem = UITabBarItem(title: "Wishlist", image: UIImage(systemName: "heart.fill"), tag: 3)

        let cartPageVC = UIHostingController(
            rootView: CartPage()
                .environmentObject(WishlistManager.shared)
                .environmentObject(CartManager.shared)
        )
        cartPageVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart.fill"), tag: 4)

        viewControllers = [homePageVC, categoriesPageVC, shopVC, wishlistPageVC, cartPageVC]
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let index = viewControllers?.firstIndex(of: viewController), index == 3 || index == 4 {
            if isGuestUser {
                presentAuthorizationScreen()
                return false
            }
        }
        return true
    }

    private func presentAuthorizationScreen() {
        let authorizationVC = AuthorizationPage()
        let navController = UINavigationController(rootViewController: authorizationVC)
        navController.modalPresentationStyle = .fullScreen

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
    }

}


