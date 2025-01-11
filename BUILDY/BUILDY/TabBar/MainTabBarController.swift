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
        
        let otherPageVC = CategoriesViewController()
        otherPageVC.tabBarItem = UITabBarItem(title: "კატეგორიები", image: UIImage(systemName: "carttext.page.badge.magnifyingglass"), tag: 1)
        
        let tabBarList = [homePageVC, otherPageVC]
        viewControllers = tabBarList
    }
}
