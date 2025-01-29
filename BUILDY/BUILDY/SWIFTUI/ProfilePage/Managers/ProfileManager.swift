//
//  ProfileManager.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 23.01.25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import UIKit

class ProfileManager: ObservableObject {
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var userPhone: String = ""
    @Published var userAddress: String = ""
    @Published var profileImage: UIImage?

    private let db = Firestore.firestore()
    private var userID: String? {
        return Auth.auth().currentUser?.uid
    }

    func fetchUserProfile() {
        guard let userID = userID else { return }
        db.collection("users").document(userID).collection("userInfo").document("profile").getDocument { [weak self] document, error in
            guard let self = self else { return }

            if let error = error {
                print("Error fetching user profile: \(error.localizedDescription)")
                return
            }

            if let data = document?.data() {
                self.userName = data["name"] as? String ?? "Unknown"
                self.userEmail = data["email"] as? String ?? "Unknown"
                self.userPhone = data["phoneNumber"] as? String ?? ""
                self.userAddress = data["address"] as? String ?? ""
            }
        }
    }

    func updateUserProfile() {
        guard let userID = userID else { return }
        
        let userProfile: [String: Any] = [
            "name": userName,
            "email": userEmail,
            "phoneNumber": userPhone,
            "address": userAddress
        ]

        db.collection("users").document(userID).collection("userInfo").document("profile").setData(userProfile) { error in
            if let error = error {
                print("Error updating profile: \(error.localizedDescription)")
            } else {
                print("Profile successfully updated!")
            }
        }
    }

    func saveProfileImage(_ image: UIImage) {
        profileImage = image
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            let filename = getDocumentsDirectory().appendingPathComponent("profile.jpg")
            try? imageData.write(to: filename)
        }
    }

    func loadProfileImage() {
        let filename = getDocumentsDirectory().appendingPathComponent("profile.jpg")
        if let imageData = try? Data(contentsOf: filename) {
            profileImage = UIImage(data: imageData)
        }
    }

    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
