//
//  UserProfileManager.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 28.01.25.
//

import FirebaseFirestore

final class UserProfileManager {
    private let db = Firestore.firestore()
    
    func fetchUserProfile(userID: String, completion: @escaping (String, String, String, String) -> Void) {
        db.collection("users")
            .document(userID)
            .collection("userInfo")
            .document("profile")
            .getDocument { document, error in
                if let error = error {
                    print("Error fetching profile: \(error.localizedDescription)")
                    completion("Unknown User", "Unknown Email", "Unknown Phone", "Unknown Address")
                    return
                }
                guard let data = document?.data(),
                      let name = data["name"] as? String,
                      let email = data["email"] as? String,
                      let phone = data["phoneNumber"] as? String,
                      let address = data["address"] as? String else {
                    completion("Unknown User", "Unknown Email", "Unknown Phone", "Unknown Address")
                    return
                }
                completion(name, email, phone, address)
            }
    }
    
    func saveUserProfile(userID: String, userInfo: [String: Any]) {
        db.collection("users")
            .document(userID)
            .collection("userInfo")
            .document("profile")
            .setData(userInfo, merge: true) { error in
                if let error = error {
                    print("Error saving user info: \(error.localizedDescription)")
                }
            }
    }
}
