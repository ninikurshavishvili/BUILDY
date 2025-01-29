//
//  MainTabBarController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 05.01.25.
//
import UIKit
import SwiftUI

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    private let tabBarManager = TabBarManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        tabBar.tintColor = AppColors.customOrange

        applyBlurEffectToTabBar()

        viewControllers = tabBarManager.setupTabBar()
    }

    private func applyBlurEffectToTabBar() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = tabBar.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.insertSubview(blurEffectView, at: 0)
        
        tabBar.layer.cornerRadius = 16
        tabBar.layer.masksToBounds = true
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let index = viewControllers?.firstIndex(of: viewController) {
            return tabBarManager.shouldAllowTabSelection(at: index)
        }
        return true
    }
}

