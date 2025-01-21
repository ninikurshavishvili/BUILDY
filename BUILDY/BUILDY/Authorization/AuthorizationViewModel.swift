//
//  AuthorizationViewModel.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 04.01.25.
//


import FirebaseAuth
import FirebaseFirestore

class AuthorizationViewModel {
    var onSignInSuccess: ((User) -> Void)?
    var onSignInFailure: ((String) -> Void)?
    var onCreateAccountRequested: (() -> Void)?
    var onSignInRequested: (() -> Void)?

    private let db = Firestore.firestore()
    private var cartItems: [Product: Int] = [:]

    var isGuest: Bool {
        return UserDefaults.standard.bool(forKey: "isGuest")
    }

    var userID: String? {
        return UserDefaults.standard.string(forKey: "userUID")
    }

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
                UserDefaults.standard.set(false, forKey: "isGuest") 
                self.onSignInSuccess?(user)
            } else {
                self.onSignInFailure?("Unexpected error occurred.")
            }
        }
    }

    func createAccount(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            onSignInFailure?("Email and password must not be empty.")
            return
        }

        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }

            if let error = error {
                self.onSignInFailure?(error.localizedDescription)
                return
            }

            if let user = result?.user {
                UserDefaults.standard.set(user.email, forKey: "userEmail")
                UserDefaults.standard.set(user.uid, forKey: "userUID")
                UserDefaults.standard.set(false, forKey: "isGuest")
                self.onSignInSuccess?(user)
            }
        }
    }

    func enterAsGuest() {
        UserDefaults.standard.set(true, forKey: "isGuest")
        UserDefaults.standard.removeObject(forKey: "userUID")
        UserDefaults.standard.removeObject(forKey: "userEmail")
    }
}



