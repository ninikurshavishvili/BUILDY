//
//  AddCardManager.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 24.01.25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class AddCardManager: ObservableObject {
    @Published var cardNumber: String = ""
    @Published var expiryDate: String = ""
    @Published var cvv: String = ""

    private let db = Firestore.firestore()
    private var userID: String? {
        return Auth.auth().currentUser?.uid
    }

    func fetchUserCard() {
        guard let userID = userID else { return }
        db.collection("users").document(userID).collection("creditCard").document("cardInfo").getDocument { [weak self] document, error in
            guard let self = self else { return }

            if let error = error {
                print("Error fetching credit card: \(error.localizedDescription)")
                return
            }

            if let data = document?.data() {
                self.cardNumber = data["cardNumber"] as? String ?? ""
                self.expiryDate = data["expiryDate"] as? String ?? ""
                self.cvv = data["cvv"] as? String ?? ""
            }
        }
    }

    func saveUserCard() {
        guard let userID = userID else { return }
        
        let cardDetails: [String: Any] = [
            "cardNumber": encryptCardNumber(cardNumber),
            "expiryDate": expiryDate,
            "cvv": encryptCVV(cvv)
        ]

        db.collection("users").document(userID).collection("creditCard").document("cardInfo").setData(cardDetails) { error in
            if let error = error {
                print("Error saving credit card: \(error.localizedDescription)")
            } else {
                print("Credit card successfully saved!")
            }
        }
    }

    func deleteUserCard() {
        guard let userID = userID else { return }
        
        db.collection("users").document(userID).collection("creditCard").document("cardInfo").delete { error in
            if let error = error {
                print("Error deleting card: \(error.localizedDescription)")
            } else {
                print("Credit card successfully deleted!")
                self.cardNumber = ""
                self.expiryDate = ""
                self.cvv = ""
            }
        }
    }

    private func encryptCardNumber(_ number: String) -> String {
        guard number.count >= 4 else { return number }
        let lastFour = number.suffix(4)
        return "**** **** **** \(lastFour)"
    }

    private func encryptCVV(_ code: String) -> String {
        return String(repeating: "*", count: code.count)
    }
}
