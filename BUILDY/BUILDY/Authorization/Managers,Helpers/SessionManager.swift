//
//  SessionManager.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 28.01.25.
//

import Foundation
import FirebaseAuth

final class SessionManager {
    static let shared = SessionManager()
    
    var isGuest: Bool {
        return UserDefaults.standard.bool(forKey: "isGuest")
    }
    var userID: String? {
        return Auth.auth().currentUser?.uid
    }
    
    func enterAsGuest() {
        UserDefaults.standard.set(true, forKey: "isGuest")
        UserDefaults.standard.removeObject(forKey: "userUID")
    }
    
    func restoreSession(completion: @escaping (User?) -> Void) {
        if let user = Auth.auth().currentUser {
            UserDefaults.standard.set(false, forKey: "isGuest")
            UserDefaults.standard.set(user.uid, forKey: "userUID")
            completion(user)
        } else {
            enterAsGuest()
            completion(nil)
        }
    }

}
