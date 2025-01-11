//
//  AuthorizationViewModel.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 04.01.25.
//


import Foundation

class AuthorizationViewModel {
    
    var onSignInRequested: (() -> Void)?
    var onCreateAccountRequested: (() -> Void)?
    
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
    
    func signInTapped() {
        onSignInRequested?()
    }
    
    func createAccountTapped() {
        onCreateAccountRequested?()
    }
}
