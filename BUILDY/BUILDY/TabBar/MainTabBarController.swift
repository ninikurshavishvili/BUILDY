//
//  MainTabBarController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 05.01.25.
//


import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homePageVC = HomePageViewController()
        homePageVC.tabBarItem = UITabBarItem(title: "მთავარი", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let categoriesPageVC = CategoriesViewController()
        categoriesPageVC.tabBarItem = UITabBarItem(title: "კატეგორიები", image: UIImage(systemName: "carttext.page.badge.magnifyingglass"), tag: 1)
        
        let shopVC = ShopViewController()
        shopVC.tabBarItem = UITabBarItem(
            title: "მაღაზიები",
            image: UIImage(systemName: "building.2.fill"),
            tag: 2
        )
        
        let tabBarList = [homePageVC, categoriesPageVC, shopVC]
        viewControllers = tabBarList
    }
}
