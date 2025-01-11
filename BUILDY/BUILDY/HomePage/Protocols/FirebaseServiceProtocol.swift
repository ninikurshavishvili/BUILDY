//
//  FirebaseService.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 05.01.25.
//

import Foundation
import FirebaseDatabase

protocol FirebaseServiceProtocol {
    func fetchData(from path: String, completion: @escaping (Result<[String: Any], Error>) -> Void)
}

class FirebaseService: FirebaseServiceProtocol {
    private let database = Database.database().reference()

    func fetchData(from path: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        database.child(path).observeSingleEvent(of: .value) { snapshot in
            if let data = snapshot.value as? [String: Any] {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "FirebaseError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data found at path: \(path)"])))
            }
        }
    }
}
