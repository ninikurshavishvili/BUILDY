//
//  AuthorizationViewModel.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 04.01.25.
//


import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import FirebaseCore
import UIKit
import SwiftUI

final class AuthorizationViewModel {
    private let authManager = AuthenticationManager.shared
    private let profileManager = UserProfileManager()
    private let sessionManager = SessionManager.shared
    
    var onSignInSuccess: ((User) -> Void)? {
        get { authManager.onSignInSuccess }
        set { authManager.onSignInSuccess = newValue }
    }
    var onSignInFailure: ((String) -> Void)? {
        get { authManager.onSignInFailure }
        set { authManager.onSignInFailure = newValue }
    }
    var onCreateAccountRequested: (() -> Void)?
    var onSignInRequested: (() -> Void)?
    
    var isGuest: Bool {
        return sessionManager.isGuest
    }
    
    func enterAsGuest() {
        UserDefaults.standard.set(true, forKey: "isGuest")
        UserDefaults.standard.removeObject(forKey: "userUID")
    }
    
    func signInTapped() {
        onSignInRequested?()
    }
    
    func createAccountTapped() {
        onCreateAccountRequested?()
    }
    
    func signIn(email: String, password: String) {
        authManager.signIn(email: email, password: password)
    }
    
    func createAccount(email: String, password: String) {
        authManager.createAccount(email: email, password: password)
    }
    func signInWithGoogle() {
        authManager.signInWithGoogle()  
    }
    
    func fetchUserProfile(completion: @escaping (String, String, String, String) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion("Guest", "Not available", "No Phone", "No Address")
            return
        }
        profileManager.fetchUserProfile(userID: userID, completion: completion)
    }
    
    func signOut() {
        authManager.signOut()
        sessionManager.enterAsGuest()
    }
    
    func restoreSession() {
        sessionManager.restoreSession { user in
            if let user = user {
                self.onSignInSuccess?(user)
            }
        }
    }
}


extension UIApplication {
    static func getTopViewController(base: UIViewController? =
        UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return getTopViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}






