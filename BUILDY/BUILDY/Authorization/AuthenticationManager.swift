//
//  AuthenticationManager.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 23.01.25.
//


import UIKit
import FirebaseAuth

class AuthenticationManager {
    static let shared = AuthenticationManager()

    private init() {}

    func signOut() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "userUID")
            UserDefaults.standard.set(true, forKey: "isGuest")
            CartManager.shared.clearCart()

            navigateToAuthorization()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    func navigateToAuthorization() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let authorizationVC = AuthorizationPage()
            let navController = UINavigationController(rootViewController: authorizationVC)
            navController.modalPresentationStyle = .fullScreen
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
    }
}
