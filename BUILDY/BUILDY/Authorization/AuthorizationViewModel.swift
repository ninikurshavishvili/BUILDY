//
//  AuthorizationViewModel.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 04.01.25.
//


import Foundation
import FirebaseAuth

class AuthorizationViewModel {

    var onSignInSuccess: ((User) -> Void)?
    var onSignInFailure: ((String) -> Void)?
    var onCreateAccountRequested: (() -> Void)?
    
    var onSignInRequested: (() -> Void)?
    
    func signInTapped() {
        onSignInRequested?()
    }

    func createAccountTapped() {
        onCreateAccountRequested?()
    }

    func signIn(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            onSignInFailure?("Email and password must not be empty.")
            return
        }

        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }

            if let error = error {
                self.onSignInFailure?(error.localizedDescription)
                return
            }

            if let user = result?.user {
                UserDefaults.standard.set(user.email, forKey: "userEmail")
                UserDefaults.standard.set(user.uid, forKey: "userUID")
                print("🔃🔃🔃🔃🔃🔃🎬🎬🎬💥💥")
                self.onSignInSuccess?(user)
            } else {
                self.onSignInFailure?("Unexpected error occurred.")
            }
        }
    }


    func createAccount(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            print("Email and password must not be empty.")
            return
        }
        
        let isSuccess = true
        
        if isSuccess {
            print("Account successfully created for \(email).")
            onCreateAccountRequested?()
        } else {
            print("Account creation failed.")
        }
    }
}

