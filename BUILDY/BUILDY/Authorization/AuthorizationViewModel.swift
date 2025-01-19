//
//  AuthorizationViewModel.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 04.01.25.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthorizationViewModel {

    var onSignInSuccess: ((User) -> Void)?
    var onSignInFailure: ((String) -> Void)?
    var onCreateAccountRequested: (() -> Void)?
    private var userID: String? {
        return UserDefaults.standard.string(forKey: "userUID")
    }
    private let db = Firestore.firestore()
    private var cartItems: [Product: Int] = [:]


    
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
    
    func listenToCartChanges() {
        guard let userID = userID else { return }

        db.collection("users")
            .document(userID)
            .collection("cart")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error listening for cart changes: \(error.localizedDescription)")
                    return
                }
                guard let documents = snapshot?.documents else { return }

                self.cartItems.removeAll()
                for document in documents {
                    let data = document.data()
                    if let name = data["name"] as? String,
                       let price = data["price"] as? String,
                       let quantity = data["quantity"] as? Int {

                        let unit = data["unit"] as? String ?? ""
                        let featuresGeo = data["featuresGeo"] as? String ?? ""
                        let category = data["category"] as? String ?? "Unknown"
                        let link = data["link"] as? String
                        let supplier = data["supplier"] as? String ?? "Unknown"

                        let product = Product(
                            name: name,
                            price: price,
                            codeID: document.documentID,
                            unit: unit,
                            featuresGeo: featuresGeo,
                            category: category,
                            link: link,
                            imageURL: nil,
                            supplier: supplier
                        )
                        self.cartItems[product] = quantity
                    }
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

